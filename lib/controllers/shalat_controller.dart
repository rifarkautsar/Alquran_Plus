import 'dart:convert';
import 'package:http/http.dart' as http;

class ShalatController {
  static Future<Map<String, String>?> getWaktuShalat(
      double latitude, double longitude) async {
    final apiUrl =
        'https://api.aladhan.com/v1/timings?latitude=$latitude&longitude=$longitude&method=2';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Log untuk debug

        if (data['data'] != null && data['data']['timings'] != null) {
          final timings = data['data']['timings'];

          return {
            'Subuh': timings['Fajr'] ?? 'Tidak tersedia',
            'Dzuhur': timings['Dhuhr'] ?? 'Tidak tersedia',
            'Ashar': timings['Asr'] ?? 'Tidak tersedia',
            'Maghrib': timings['Maghrib'] ?? 'Tidak tersedia',
            'Isya': timings['Isha'] ?? 'Tidak tersedia',
          };
        } else {
          ('Data atau timings tidak ditemukan di respons.');
        }
      } else {
        ('Response gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      ('Error saat mengambil data dari API: $e');
    }

    // Jika gagal, kembalikan null
    return null;
  }
}
