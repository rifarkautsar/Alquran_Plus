import 'package:alquran_plus/models/quran_model.dart';

List<Surah> filterSurahList(List<Surah> surahList, String query) {
  if (query.isEmpty) {
    return surahList;
  }
  return surahList
      .where((surah) =>
          surah.nameSimple.toLowerCase().contains(query.toLowerCase()))
      .toList();
}
