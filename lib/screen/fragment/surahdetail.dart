import 'package:flutter/material.dart';
import 'package:alquran_plus/models/quran_model.dart';

class SurahDetail extends StatelessWidget {
  final Surah surah;

  const SurahDetail({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF3DC185),
        title: Text('${surah.id}. ${surah.nameSimple}',
            style: TextStyle(fontSize: 18, color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                surah.revelationPlace,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header dengan gambar latar belakang
          Container(
            height: 65, // Mengubah tinggi keseluruhan container
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/header_surah.png'), // Pastikan path gambar sesuai
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Lingkaran kiri
                Padding(
                  padding: const EdgeInsets.only(left: 33.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      surah.revelationPlace,
                      style: TextStyle(
                        fontSize: 11,
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
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Lingkaran kanan
                Padding(
                  padding: const EdgeInsets.only(right: 26.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
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


          // List ayat
          Expanded(
            child: ListView.builder(
              itemCount: surah.verses?.length,
              itemBuilder: (context, index) {
                final verse = surah.verses?[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ayat dalam teks Arab
                    Container(
                      width: double.infinity, // Lebar maksimal layar
                      color: _getBackgroundColor(index), // Warna background berbeda
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
                            '${verse.id}. ${verse.translation}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
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
