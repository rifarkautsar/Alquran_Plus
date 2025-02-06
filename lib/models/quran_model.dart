class Surah {
  final int id;
  final String nameSimple;
  final String nameArabic;
  final String revelationPlace;
  final int versesCount;
  final List<Verse>? verses;

  Surah({
    required this.id,
    required this.nameSimple,
    required this.nameArabic,
    required this.revelationPlace,
    required this.versesCount,
    required this.verses,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'] as int,
      nameSimple: json['name_simple'] as String,
      nameArabic: json['name_arabic'] as String,
      revelationPlace: json['revelation_place'] as String,
      versesCount: json['verses_count'] as int,
      verses: (json['verses'] as List<dynamic>?)
          ?.map((verse) => Verse.fromJson(verse))
          .toList(),
    );
  }
}

class Juz {
  final int id;
  final int startVerse;
  final String startSurah;

  Juz({
    required this.id,
    required this.startVerse,
    required this.startSurah,
  });

  factory Juz.fromJson(Map<String, dynamic> json) {
    return Juz(
      id: json['id'] as int,
      startVerse: json['startVerse'] as int,
      startSurah: json['startSurah'] as String,
    );
  }
}

class Verse {
  final int id;
  final String verseKey;
  final String textUthmani;
  final String translation;

  Verse({
    required this.id,
    required this.verseKey,
    required this.textUthmani,
    required this.translation,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    String cleanedTranslation =
        json['translation']?.replaceAll(RegExp(r'<sup[^>]*>.*?<\/sup>'), '') ??
            '';
    return Verse(
      id: json['id'],
      verseKey: json['verse_key'],
      textUthmani: json['text_uthmani'],
      translation: cleanedTranslation,
    );
  }
}
