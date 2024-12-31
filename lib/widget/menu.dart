import 'package:alquran_plus/screen/about_us_page.dart';
import 'package:alquran_plus/screen/alquran_page.dart';
import 'package:alquran_plus/screen/kiblat_page.dart';
import 'package:alquran_plus/screen/login.dart';
// import 'package:alquran_plus/screen/beranda_page.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:alquran_plus/screen/register.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi kalender Hijriah
    final hijriDate = HijriCalendar.now();
    print(
        'Tanggal Hijriah: ${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear}');
    print('Tanggal Gregorian: ${DateTime.now()}');

    return Drawer(
      child: Column(
        children: [
          // Header dengan Kalender Hijriah
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                // Kotak Kalender
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF3DC185),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Bagian atas dengan tanggal Hijriah
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF3DC185),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // Align items to the top
                            children: [
                              Text(
                                '${hijriDate.hDay}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Add spacing between Text and Column
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // Align items to the left
                                children: [
                                  Text(
                                    hijriDate.longMonthName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${hijriDate.hYear}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Garis pemisah
                      Divider(height: 1, color: Colors.grey.shade300),
                      // Bagian bawah dengan waktu Maghrib
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'MAGHRIB 17:51',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.black12),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 0,
              ),
              children: [
                // ListTile(
                //   leading: Icon(Icons.home, color: Colors.black38),
                //   title: Text('Beranda'),
                //   onTap: () {
                //     Navigator.pop(context);
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const Beranda()),
                //     );
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.menu_book, color: Colors.black38),
                  title: Text('Al-Quran'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlquranPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.access_time, color: Colors.black38),
                  title: Text('Waktu Sholat'),
                  onTap: () {
                    Navigator.pop(context);
                    // Tambahkan navigasi ke halaman Waktu Sholat
                  },
                ),
                ListTile(
                  leading: Icon(Icons.explore, color: Colors.black38),
                  title: Text('Kiblat'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KiblatCompass()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book, color: Colors.black38),
                  title: Text('Hisnul Muslim'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KiblatCompass()),
                    );
                  },
                ),
                const SizedBox(
                  height: 230,
                ),
                ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.black38),
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutUs()),
                    );
                  },
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3DC185),
                          foregroundColor: Colors.white),
                      child: const Text('Register'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3DC185),
                          foregroundColor: Colors.white),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
