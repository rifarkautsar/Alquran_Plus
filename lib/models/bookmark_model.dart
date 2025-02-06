class BookmarkFolder {
  final String id;
  String name;
  List<BookmarkModel> bookmarks;

  BookmarkFolder({
    required this.id,
    required this.name,
    required this.bookmarks,
  });
}

class BookmarkModel {
  final String surahName;
  final int surahNumber;
  final int verseNumber;
  final String verseText;

  BookmarkModel({
    required this.surahName,
    required this.surahNumber,
    required this.verseNumber,
    required this.verseText,
  });

  Map<String, dynamic> toJson() {
    return {
      'surahName': surahName,
      'surahNumber': surahNumber,
      'verseNumber': verseNumber,
      'verseText': verseText,
    };
  }

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      surahName: json['surahName'],
      surahNumber: json['surahNumber'],
      verseNumber: json['verseNumber'],
      verseText: json['verseText'],
    );
  }
}
