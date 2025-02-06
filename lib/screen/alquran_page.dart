import 'package:alquran_plus/models/quran_model.dart';
import 'package:alquran_plus/widget/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:alquran_plus/controllers/quran_controller.dart';
import 'package:alquran_plus/widget/menu.dart';
import 'package:alquran_plus/widget/custom_appbar.dart';
import 'package:alquran_plus/screen/fragment/surahlist.dart';
import 'package:alquran_plus/screen/fragment/juzlist.dart';
import 'fragment/bookmark.dart';

class AlquranPage extends StatefulWidget {
  const AlquranPage({super.key});

  @override
  AlquranPageState createState() => AlquranPageState();
}

class AlquranPageState extends State<AlquranPage> {
  final QuranController controller = QuranController();
  List<Surah> filteredSurahList = []; // Daftar Surah yang sudah difilter
  String query = ''; // Query pencarian

  @override
  void initState() {
    super.initState();
    controller.loadAllData().then((_) {
      setState(() {
        filteredSurahList = controller.surahList; // Set daftar Surah default
      });
    });
  }

  List<Surah> filterSurahList(List<Surah> originalList, String query) {
    if (query.isEmpty) {
      return originalList; // Jika query kosong, kembalikan semua Surah
    }
    return originalList
        .where((surah) =>
            surah.nameSimple.toLowerCase().contains(query.toLowerCase()) ||
            surah.nameArabic.contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah total tab
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Al-Quran',
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CustomSearchBar(
                onSearch: (String query) {
                  setState(() {
                    this.query = query;
                    filteredSurahList =
                        filterSurahList(controller.surahList, query);
                  });
                },
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'SURAH'),
              Tab(text: 'JUZ'),
              Tab(text: 'BOOKMARK'),
            ],
          ),
        ),
        drawer: const Menu(),
        body: TabBarView(
          children: [
            SurahList(
                surahList: filteredSurahList), // Kirim daftar yang difilter
            JuzList(controller: controller), // Halaman daftar Juz
            BookmarkPage()
          ],
        ),
      ),
    );
  }
}
