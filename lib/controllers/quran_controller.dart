import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:alquran_plus/models/quran_model.dart';

class QuranController {
  List<Surah> surahList = [];
  List<Juz> juzList = [];

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

  // Fungsi untuk mendapatkan detail surah berdasarkan ID
  Surah? getSurahDetails(int surahId) {
    try {
      return surahList.firstWhere((surah) => surah.id == surahId);
    } catch (e) {
      ('Error fetching surah details: $e');
      return null;
    }
  }

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

  // Muat kedua data Surah dan Juz
  Future<void> loadAllData() async {
    await loadSurahData();
    await loadJuzData();
  }
}
