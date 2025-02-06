import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class KiblatCompass extends StatefulWidget {
  const KiblatCompass({super.key});

  @override
  KiblatCompassState createState() => KiblatCompassState();
}

class KiblatCompassState extends State<KiblatCompass> {
  double? _qiblaDirection;
  double? _heading;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events?.listen((event) {
      setState(() {
        _heading = event.heading;
      });
    });
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    if (!await Geolocator.isLocationServiceEnabled()) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Lokasi Dinonaktifkan'),
            content:
                Text('Aktifkan lokasi perangkat untuk menentukan arah kiblat.'),
          ),
        );
      }
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    await _fetchQiblaDirection(position.latitude, position.longitude);
  }

  Future<void> _fetchQiblaDirection(double lat, double lon) async {
    final url = Uri.parse(
        'https://g123x3vju0.execute-api.ap-southeast-1.amazonaws.com/v1/Qibla?lat=$lat&lon=$lon');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _qiblaDirection = data['qibla_direction'];
        });
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Gagal mendapatkan arah kiblat: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kiblat'),
      ),
      body: Center(
        child: _qiblaDirection == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Arah Kiblat: ${_qiblaDirection!.toStringAsFixed(2)}°',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Transform.rotate(
                    angle: ((_heading ?? 0) - (_qiblaDirection ?? 0)) *
                        (pi / 180) *
                        -1,
                    child: Image.asset(
                      'assets/images/compass.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Kiblat berada di atas arah kepala kabah',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
      ),
    );
  }
}
