// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:alquran_plus/controllers/storage.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  BookmarkPageState createState() => BookmarkPageState();
}

class BookmarkPageState extends State<BookmarkPage> {
  final StorageService _storageService = StorageService();
  List<String> folders = [];

  @override
  void initState() {
    super.initState();
    _loadFolders();
  }

  Future<void> _loadFolders() async {
    await _storageService.createDefaultFolder();
    final loadedFolders = await _storageService.getFolders();
    setState(() {
      folders = loadedFolders;
    });
  }

  void _showFolderBookmarks(String folderName) async {
    final bookmarks = await _storageService.getBookmarks(folderName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bookmarks in $folderName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: bookmarks.map((bookmark) {
            return ListTile(
              title: Text(bookmark),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await _storageService.removeBookmark(folderName, bookmark);
                  Navigator.pop(context);
                  _showFolderBookmarks(folderName);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _deleteFolder(String folderName) async {
    await _storageService.deleteFolder(folderName);
    _loadFolders();
  }

  void _addFolder() async {
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
                _loadFolders();
              }
            },
            child: const Text('Simpan'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Folders'),
      ),
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.folder, color: Color(0xFFBBA27A)),
            title: Text(folders[index]),
            onTap: () => _showFolderBookmarks(folders[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteFolder(folders[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFolder,
        child: const Icon(Icons.add),
      ),
    );
  }
}
