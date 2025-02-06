import 'package:flutter/material.dart';
import 'package:alquran_plus/controllers/location_controller.dart';
import 'package:alquran_plus/controllers/shalat_controller.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  PrayerTimesScreenState createState() => PrayerTimesScreenState();
}

class PrayerTimesScreenState extends State<PrayerTimesScreen> {
  final LocationController _locationService = LocationController();
  final ShalatController _prayerTimesService = ShalatController();

  Map<String, dynamic>? _prayerTimes;
  bool _isLoading = false;
  bool _locationEnabled = true;

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimes();
  }

  Future<void> _fetchPrayerTimes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final location = await _locationService.getLocation();
      if (location == null) {
        setState(() {
          _locationEnabled = false;
        });
        return;
      }

      final times = await _prayerTimesService.fetchPrayerTimesByCoordinates(
          location.latitude!, location.longitude!);
      setState(() {
        _prayerTimes = times;
        _locationEnabled = true;
      });
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waktu Shalat")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : !_locationEnabled
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Akses lokasi diperlukan untuk menampilkan waktu shalat.",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _fetchPrayerTimes,
                        child: Text("Aktifkan Lokasi"),
                      ),
                    ],
                  ),
                )
              : _prayerTimes == null
                  ? Center(child: Text("Tidak ada data waktu shalat."))
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: _prayerTimes!.length,
                      itemBuilder: (context, index) {
                        final keys = _prayerTimes!.keys.toList();
                        final values = _prayerTimes!.values.toList();

                        // Ikon dan warna untuk waktu shalat
                        final icons = [
                          Icons.access_alarm, // Subuh
                          Icons.wb_sunny, // Terbit
                          Icons.sunny_snowing, // Dzuhur
                          Icons.timelapse, // Ashar
                          Icons.nightlight_round, // Maghrib
                          Icons.brightness_3, // Isya
                        ];

                        return ListTile(
                          leading: Icon(
                            icons[index % icons.length],
                            color: index == 4 ? Colors.orange : Colors.grey,
                          ),
                          title: Text(
                            keys[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == 4 ? Colors.orange : Colors.black,
                            ),
                          ),
                          trailing: Text(
                            values[index],
                            style: TextStyle(
                              color: index == 4 ? Colors.orange : Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
