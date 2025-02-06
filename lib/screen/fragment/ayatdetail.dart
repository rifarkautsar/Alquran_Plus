// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alquran_plus/controllers/audio_controller.dart';
import 'package:provider/provider.dart';
import 'package:alquran_plus/controllers/storage.dart';

class VerseDrawer extends StatefulWidget {
  final String verseNumber;
  final String verseText;
  final String surahName;
  final int surahNumber;

  const VerseDrawer({
    super.key,
    required this.verseNumber,
    required this.verseText,
    required this.surahName,
    required this.surahNumber,
  });

  @override
  VerseDrawerState createState() => VerseDrawerState();
}

class VerseDrawerState extends State<VerseDrawer> {
  final StorageService _storageService = StorageService();

  void _showAddBookmarkDialog() async {
    if (!mounted) return;
    final folders = await _storageService.getFolders();

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pilih Folder'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: folders.map((folder) {
                return ListTile(
                  title: Text(folder),
                  onTap: () async {
                    await _storageService.addBookmark(
                      folder,
                      'QS ${widget.surahName} : ${widget.verseNumber}',
                    );
                    Navigator.pop(context); // Tutup dialog pemilihan folder
                    Navigator.pop(context); // Tutup modal bottom sheet
                    _showFloatingSnackBar(
                        'Bookmark berhasil ditambahkan ke $folder');
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: _createNewFolder,
              child: const Text('Tambah Folder Baru'),
            ),
          ],
        );
      },
    );
  }

  void _createNewFolder() async {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Folder'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await _storageService.addFolder(controller.text);
                Navigator.pop(context);
                _showAddBookmarkDialog();
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showFloatingSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(40),
        backgroundColor: Color(0xFF3DC185),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.transparent,
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.5,
          minChildSize: 0.3,
          snap: true,
          snapSizes: [0.5],
          builder: (context, scrollController) {
            return GestureDetector(
              onTap:
                  () {}, // Mencegah tap dari menutup drawer ketika mengklik di dalam drawer
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'QS ${widget.surahName} : ${widget.verseNumber}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Consumer<AudioController>(
                              builder: (context, audioController, child) {
                                return IconButton(
                                  icon: Icon(
                                    audioController.isPlaying &&
                                            audioController.currentAyah ==
                                                int.parse(widget.verseNumber)
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                  onPressed: () async {
                                    final int surah = widget.surahNumber;
                                    final int ayah =
                                        int.parse(widget.verseNumber);
                                    await audioController.playAudio(
                                        surah, ayah);
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.stop),
                              onPressed: () async {
                                context.read<AudioController>().stopAudio();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.copy),
                      title: Text('Salin Ayat'),
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(
                            text:
                                'Ayat ${widget.verseNumber}\n\n${widget.verseText}',
                          ),
                        );
                        Navigator.pop(context);
                        Navigator.pop(context); // Tutup modal bottom sheet
                        _showFloatingSnackBar('Ayat Berhasil diSalin');
                      },
                    ),
                    ListTile(
                        leading: Icon(Icons.bookmark_add),
                        title: Text('Tambah ke Bookmark'),
                        onTap: _showAddBookmarkDialog),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
