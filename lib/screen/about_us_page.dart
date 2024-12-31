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
                'About Us\n\n'
                'Selamat datang di Al-Quran Plus, aplikasi yang dirancang untuk memberikan pengalaman membaca Al-Quran yang lengkap dan nyaman bagi umat Islam di seluruh dunia.\n\n'
                'Tujuan utama kami adalah:\n\n'
                'Mendekatkan Anda kepada Al-Quran: Kami menyediakan teks Al-Quran lengkap dengan terjemahan dan tafsir untuk membantu Anda memahami maknanya dengan lebih baik.\n'
                'Kemudahan dan Interaktivitas: Aplikasi ini dilengkapi dengan fitur pencarian, bookmark, dan pengingat harian untuk mempermudah perjalanan spiritual Anda.\n'
                'Meningkatkan Ibadah Harian: Selain Al-Quran, kami juga menyediakan fitur seperti doa harian, jadwal sholat, dan arah kiblat.\n\n'
                'Fitur Utama:\n\n'
                'Teks Al-Quran 30 Juz dengan berbagai pilihan terjemahan.\n'
                'Tafsir yang membantu memahami konteks dan makna ayat.\n'
                'Audio murottal dari qari terkenal untuk membantu Anda memperbaiki bacaan.\n'
                'Fitur bookmark dan catatan pribadi untuk mencatat pemahaman Anda.\n\n'
                'Kami berkomitmen untuk terus meningkatkan aplikasi ini agar menjadi sahabat terbaik Anda dalam memperdalam iman dan mendekatkan diri kepada Allah SWT.\n\n'
                'Terima kasih telah mempercayai kami sebagai bagian dari perjalanan spiritual Anda.\n\n'
                'Jika Anda memiliki saran atau pertanyaan, jangan ragu untuk menghubungi kami di:\n'
                '📧 email@example.com\n\n'
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
