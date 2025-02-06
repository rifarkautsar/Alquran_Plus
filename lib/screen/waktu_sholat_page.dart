import 'package:alquran_plus/controllers/location_controller.dart';
import 'package:alquran_plus/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:alquran_plus/controllers/shalat_controller.dart';
import 'package:alquran_plus/widget/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'kota.dart';
import 'dart:convert';

class WaktuSholatPage extends StatefulWidget {
  const WaktuSholatPage({super.key});

  @override
  WaktuSholatPageState createState() => WaktuSholatPageState();
}

class WaktuSholatPageState extends State<WaktuSholatPage> {
  String _lokasi = "Pilih lokasi";
  Map<String, String>? _jadwalShalat;
  bool _isLoading = false;
  final Map<String, bool> _alarmAktif = {};
  String? _jamAlarmManual;

  @override
  void initState() {
    super.initState();
    NotificationHelper.initialize();
    _loadLastData();
  }

  Future<void> _loadLastData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lokasi = prefs.getString('last_location') ?? "Pilih lokasi";
      final jadwalData = prefs.getString('last_jadwal');
      if (jadwalData != null) {
        try {
          _jadwalShalat = Map<String, String>.from(json.decode(jadwalData));
        } catch (e) {
          _jadwalShalat = null;
        }
      }
    });
    _loadAlarmStatus();
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_location', _lokasi);
    if (_jadwalShalat != null) {
      await prefs.setString('last_jadwal', json.encode(_jadwalShalat));
    }
  }

  Future<void> _setLokasiOtomatis() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showGpsAlertDialog();
      return;
    }

    setState(() => _isLoading = true);

    try {
      Position? position = await LocationController.getCurrentLocation();
      if (position != null) {
        String? namaLokasi = await LocationController.getPlaceName(
            position.latitude, position.longitude);

        final jadwal = await ShalatController.getWaktuShalat(
            position.latitude, position.longitude);

        if (jadwal != null) {
          setState(() {
            _lokasi = namaLokasi ?? "Lokasi tidak diketahui";
            _jadwalShalat = jadwal;
          });
          await _saveData();
          _initializeAlarmStatus();
        } else {
          setState(() => _lokasi = "Gagal mendapatkan jadwal shalat");
        }
      } else {
        setState(() => _lokasi = "Gagal mendapatkan lokasi otomatis");
      }
    } catch (e) {
      setState(() => _lokasi = "Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showGpsAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("GPS Tidak Aktif"),
          content:
              Text("Silakan aktifkan GPS untuk menggunakan lokasi otomatis."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _setLokasiManualOverlay(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Pilih Lokasi Manual",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: Kota.daftarKota.map((kota) {
                      return ListTile(
                        title: Text(kota.nama),
                        onTap: () async {
                          Navigator.pop(context);
                          setState(() => _isLoading = true);

                          final jadwal = await ShalatController.getWaktuShalat(
                              kota.latitude, kota.longitude);

                          if (jadwal != null) {
                            setState(() {
                              _lokasi = kota.nama;
                              _jadwalShalat = jadwal;
                              _initializeAlarmStatus();
                            });
                            await _saveData();
                          } else {
                            setState(() => _lokasi =
                                "Gagal mendapatkan jadwal untuk ${kota.nama}");
                          }

                          setState(() => _isLoading = false);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _initializeAlarmStatus() {
    if (_jadwalShalat != null) {
      for (var waktu in _jadwalShalat!.keys) {
        _alarmAktif[waktu] = false;
      }
    }
  }

  Future<void> _toggleAlarm(String waktu, String jam) async {
    setState(() {
      _alarmAktif[waktu] = !(_alarmAktif[waktu] ?? false);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alarm_$waktu', _alarmAktif[waktu]!);

    if (_alarmAktif[waktu]!) {
      List<String> jamMenit = jam.split(':');
      if (jamMenit.length == 2) {
        final now = DateTime.now();
        final jadwalTime = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(jamMenit[0]),
          int.parse(jamMenit[1]),
        );

        final scheduledTime = jadwalTime.isAfter(now)
            ? jadwalTime
            : jadwalTime.add(const Duration(days: 1));

        ("Menjadwalkan notifikasi untuk: $scheduledTime");
        NotificationHelper.showAdzanNotification(
          title: 'Waktunya Shalat',
          body: 'Saatnya menunaikan shalat $waktu',
        );

        ("Notifikasi berhasil dijadwalkan");
      }
    }
  }

  Future<void> _loadAlarmStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_jadwalShalat != null) {
      for (var waktu in _jadwalShalat!.keys) {
        _alarmAktif[waktu] = prefs.getBool('alarm_$waktu') ?? false;
      }
    }
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Jadwal Shalat',
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Set GPS') {
                _setLokasiOtomatis();
              } else if (value == 'Set Manual') {
                _setLokasiManualOverlay(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'Set GPS', child: Text('Set Lokasi Otomatis (GPS)')),
              const PopupMenuItem(
                  value: 'Set Manual', child: Text('Set Lokasi Manual')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_jamAlarmManual != null)
              Text(
                "Alarm dinyalakan: $_jamAlarmManual",
                style: const TextStyle(fontSize: 12, color: Colors.green),
              ),
            const SizedBox(height: 8),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lokasi Saat Ini",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _lokasi,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _jadwalShalat == null
                      ? const Center(
                          child: Text(
                            "Silakan pilih lokasi untuk menampilkan jadwal shalat",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _jadwalShalat!.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 0, color: Colors.grey),
                          itemBuilder: (context, index) {
                            final waktu = _jadwalShalat!.keys.toList()[index];
                            final jam = _jadwalShalat!.values.toList()[index];
                            final isAlarmAktif = _alarmAktif[waktu] ?? false;

                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 0),
                              leading: CircleAvatar(
                                radius: 7,
                                backgroundColor: Colors.green,
                              ),
                              title: Text(
                                waktu,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(jam),
                              trailing: IconButton(
                                icon: Icon(
                                  isAlarmAktif
                                      ? Icons.alarm_on
                                      : Icons.alarm_off,
                                  color:
                                      isAlarmAktif ? Colors.green : Colors.grey,
                                ),
                                onPressed: () {
                                  _toggleAlarm(waktu, jam);
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
