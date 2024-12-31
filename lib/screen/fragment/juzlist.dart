import 'package:flutter/material.dart';
import 'package:alquran_plus/controllers/quran_controller.dart';

class JuzList extends StatelessWidget {
  final QuranController controller;

  const JuzList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Menampilkan pesan jika juzList kosong
    if (controller.juzList.isEmpty) {
      return const Center(child: Text("No Juz available"));
    }

    return ListView.builder(
      itemCount: controller.juzList.length,
      itemBuilder: (context, index) {
        final juz = controller.juzList[index];
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Juz ${juz.id}'),
                    subtitle: Text(
                      'MULAI SURAH ${juz.startSurah} AYAT ${juz.startVerse}',
                      style: TextStyle(color: Colors.brown.shade300),
                    ),
                    onTap: () {
                      // Navigasi ke halaman detail Juz
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
