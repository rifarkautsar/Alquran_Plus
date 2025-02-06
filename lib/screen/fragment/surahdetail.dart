import 'package:alquran_plus/screen/fragment/ayatdetail.dart';
import 'package:flutter/material.dart';
import 'package:alquran_plus/models/quran_model.dart';

class SurahDetail extends StatelessWidget {
  final Surah surah;

  const SurahDetail({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 34,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF3DC185),
        title: Text(
          '${surah.id}. ${surah.nameSimple}',
          style: TextStyle(fontSize: 14, color: const Color(0xFFF8F8F8)),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF1E4C6),
            ),

            // Header dengan gambar latar belakang
            child: Center(
              child: Container(
                height: 52, // Mengubah tinggi keseluruhan container
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/icon.png'),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Lingkaran kiri
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color(0xFFCEB285), width: 1.5),
                            color: Color(0xFFFFF4CF)),
                        alignment: Alignment.center,
                        child: Text(
                          surah.revelationPlace,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    // Judul Surah
                    Padding(
                      padding: const EdgeInsets.only(right: 3.0),
                      child: Text(
                        surah.nameSimple,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Lingkaran kanan
                    Padding(
                      padding: const EdgeInsets.only(right: 45.0),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color(0xFFCEB285), width: 1.5),
                            color: Color(0xFFFFF4CF)),
                        alignment: Alignment.center,
                        child: Text(
                          '${surah.versesCount}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // List ayat
          Expanded(
            child: ListView.builder(
              itemCount: surah.verses?.length,
              itemBuilder: (context, index) {
                final verse = surah.verses?[index];
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return VerseDrawer(
                          verseNumber: '${index + 1}',
                          verseText:
                              '${verse.textUthmani}\n\n${verse.translation}',
                          surahName: surah.nameSimple,
                          surahNumber: surah.id, // Nomor surah
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity, // Lebar maksimal layar
                    color:
                        _getBackgroundColor(index), // Warna background berbeda
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Teks Arab di sebelah kanan
                        Text(
                          verse!.textUthmani,
                          style: const TextStyle(
                            fontFamily: 'Arabic',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        // Terjemahan di sebelah kiri
                        Text(
                          '${index + 1}. ${verse.translation}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk mendapatkan warna background berbeda
  Color _getBackgroundColor(int index) {
    // Daftar warna latar belakang (hanya 2 warna)
    final List<Color> backgroundColors = [
      Color(0xFFFFFAEB), // Warna krem muda
      Color(0xFFFFFFFF), // Hijau muda
    ];

    // Kembalikan warna berdasarkan indeks, berulang antara 2 warna
    return backgroundColors[index % backgroundColors.length];
  }
}
