import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> createDefaultFolder() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('folders')) {
      prefs.setStringList('folders', ['Default']);
    }
  }

  Future<List<String>> getFolders() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('folders') ?? ['Default'];
  }

  Future<void> addFolder(String folderName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> folders = await getFolders();
    if (!folders.contains(folderName)) {
      folders.add(folderName);
      prefs.setStringList('folders', folders);
    }
  }

  Future<void> addBookmark(String folderName, String bookmark) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(folderName) ?? [];
    bookmarks.add(bookmark);
    prefs.setStringList(folderName, bookmarks);
  }

  Future<List<String>> getBookmarks(String folderName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(folderName) ?? [];
  }

  Future<void> removeBookmark(String folderName, String bookmark) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = await getBookmarks(folderName);
    bookmarks.remove(bookmark);
    prefs.setStringList(folderName, bookmarks);
  }

  Future<void> deleteFolder(String folderName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> folders = await getFolders();
    folders.remove(folderName);
    prefs.remove(folderName);
    prefs.setStringList('folders', folders);
  }
}
