import 'package:cached_network_image/cached_network_image.dart';
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
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              'assets/images/logo_id.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 35,
                      height: 35,
                      child: Center(
                        child: Text(
                          surah.id.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
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
