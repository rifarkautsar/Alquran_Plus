import 'package:alquran_plus/widget/menu.dart';
import 'package:flutter/material.dart';
import 'package:alquran_plus/widget/custom_appbar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'About Us',
      ),
      drawer: const Menu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang di Al-Quran Plus, aplikasi yang dirancang untuk memberikan pengalaman membaca Al-Quran yang lengkap dan nyaman bagi umat Islam.\n\n'
                'Tujuan utama kami adalah:\n\n'
                'Mendekatkan Anda kepada Al-Quran: Kami menyediakan teks Al-Quran lengkap dengan terjemahan Indonesia untuk membantu Anda memahami maknanya dengan lebih baik.\n'
                'Kemudahan dan Interaktivitas: Aplikasi ini dilengkapi dengan fitur pencarian, bookmark, dan pengingat harian untuk mempermudah perjalanan spiritual Anda.\n'
                'Selain Al-Quran, kami juga menyediakan fitur seperti jadwal sholat dan arah kiblat.\n\n'
                'Fitur Utama:\n\n'
                '- Teks Al-Quran 30 Juz dengan terjemahan Indonesia.\n'
                '- Audio murottal dari qari terkenal untuk membantu Anda memperbaiki bacaan.\n'
                '- Fitur bookmark untuk menyimpan sesuai dengan keinginan Anda.\n\n'
                'Kami berkomitmen untuk terus meningkatkan aplikasi ini agar menjadi sahabat terbaik Anda dalam memperdalam iman dan mendekatkan diri kepada Allah سُبْحَانَهُ وَ تَعَالَى.\n\n'
                'Terima kasih telah mempercayai kami sebagai bagian dari perjalanan spiritual Anda.\n\n'
                'Jika Anda memiliki saran atau pertanyaan, jangan ragu untuk menghubungi kami di:\n'
                '📨 alquranplus@gmail.com\n\n'
                'Jika Anda memiliki saran atau masalah pada aplikasi, jangan ragu untuk menghubungi teknisi kami di:\n'
                '📨 rizkifatahillahkautsar@gmail.com\n\n'
                'Semoga aplikasi ini menjadi berkah bagi kita semua.\n'
                'Wassalamualaikum warahmatullahi wabarakatuh.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
