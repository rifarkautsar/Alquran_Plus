import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:alquran_plus/models/quran_model.dart';

class QuranController {
  List<Surah> surahList = [];
  List<Juz> juzList = [];

  /// Load Surah Data from JSON
  Future<void> loadSurahData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data_quran/DataSurah.json');
      final List<dynamic> data = json.decode(response);
      surahList = data.map((json) => Surah.fromJson(json)).toList();
    } catch (e) {
      ('Error loading Surah data: $e');
    }
  }

  /// Get Surah Details by ID
  Surah? getSurahDetails(int surahId) {
    try {
      return surahList.firstWhere((surah) => surah.id == surahId);
    } catch (e) {
      ('Error fetching surah details: $e');
      return null;
    }
  }

  /// Load Juz Data from JSON
  Future<void> loadJuzData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data_quran/DataJuz.json');
      final List<dynamic> data = json.decode(response);
      juzList = data.map((json) => Juz.fromJson(json)).toList();
    } catch (e) {
      ('Error loading Juz data: $e');
    }
  }

  /// Load both Surah and Juz Data
  Future<void> loadAllData() async {
    await loadSurahData();
    await loadJuzData();
  }
}
