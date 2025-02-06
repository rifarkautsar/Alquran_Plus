import 'dart:convert';
import 'package:http/http.dart' as http;

class ShalatController {
  final String apiUrl = "https://api.aladhan.com/v1/timings";

  Future<Map<String, dynamic>> fetchPrayerTimesByCoordinates(
      double latitude, double longitude) async {
    final url =
        Uri.parse('$apiUrl?latitude=$latitude&longitude=$longitude&method=2');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['timings'];
    } else {
      throw Exception("Failed to load prayer times");
    }
  }
}
