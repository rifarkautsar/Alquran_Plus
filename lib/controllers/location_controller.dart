import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController {
  // Mendapatkan posisi lokasi saat ini
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Memeriksa apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    // Memeriksa dan meminta izin lokasi jika diperlukan
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    // Mengatur parameter akurasi lokasi
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  // Mendapatkan nama tempat berdasarkan koordinat
  static Future<String?> getPlaceName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        // Kembalikan informasi detail lokasi
        return [
          place.subLocality, // Nama area kecil (kelurahan)
          place.locality, // Kota
          place.administrativeArea, // Provinsi
          place.country // Negara
        ].where((element) => element != null && element.isNotEmpty).join(', ');
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
