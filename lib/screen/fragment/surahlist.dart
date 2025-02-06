import 'package:flutter/material.dart';
import 'package:alquran_plus/models/quran_model.dart';
import 'package:alquran_plus/screen/fragment/surahdetail.dart';

class SurahList extends StatelessWidget {
  final List<Surah> surahList; // Daftar Surah yang diterima

  const SurahList({super.key, required this.surahList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surahList.length, // Gunakan daftar yang difilter
      itemBuilder: (context, index) {
        final surah = surahList[index];
        return Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1E4C6),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFBBA27A)),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 31,
                          height: 31,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFF1E4C6),
                              width: 2,
                            ),
                          ),
                        ),
                        Text(
                          surah.id.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(surah.nameSimple),
                    subtitle: Text(
                      '${surah.revelationPlace.toUpperCase()} | ${surah.versesCount}',
                      style: TextStyle(color: Colors.brown.shade300),
                    ),
                    trailing: Text(
                      surah.nameArabic,
                      style: const TextStyle(
                        fontFamily: 'Arab',
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SurahDetail(surah: surah), // Pindah ke detail
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Divider(height: 1, color: Colors.grey),
          ],
        );
      },
    );
  }
}
