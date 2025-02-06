import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int? currentSurah;
  int? currentAyah;

  AudioController() {
    _audioPlayer.onPlayerComplete.listen((event) {
      _playNextAyah(); // Lanjutkan ke ayat berikut jika masih ada
    });
  }

  String _getAudioUrl(int surah, int ayah) {
    String surahKey = surah.toString().padLeft(3, '0');
    String ayahKey = ayah.toString().padLeft(3, '0');
    return 'https://verses.quran.com/Alafasy/mp3/$surahKey$ayahKey.mp3';
  }

  Future<void> playAudio(int surah, int ayah) async {
    currentSurah = surah;
    currentAyah = ayah;

    final String audioUrl = _getAudioUrl(surah, ayah);
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setSourceUrl(audioUrl);
      await _audioPlayer.resume();
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    isPlaying = false;
    currentSurah = null;
    currentAyah = null;
    notifyListeners();
  }

  Future<void> _playNextAyah() async {
    if (currentSurah != null && currentAyah != null) {
      currentAyah = currentAyah! + 1;
      final String nextAudioUrl = _getAudioUrl(currentSurah!, currentAyah!);

      // Coba set audio, jika gagal anggap ayat sudah habis
      try {
        await _audioPlayer.stop();
        await _audioPlayer.setSourceUrl(nextAudioUrl);
        await _audioPlayer.resume();
        notifyListeners();
      } catch (e) {
        debugPrint('Error loading ayah: $e');
        await stopAudio(); // Berhenti jika tidak ada audio berikutnya
      }
    }
  }
}
