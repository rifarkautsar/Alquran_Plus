import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static AudioPlayer _audioPlayer =
      AudioPlayer(); // Inisialisasi satu instance audio player

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.notificationResponseType ==
            NotificationResponseType.selectedNotification) {
          stopAdzanSound(); // Hentikan saat notifikasi di-tap
        }
      },
    );
  }

  static Future<void> showAdzanNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'adzan_channel',
      'Adzan Notifications',
      channelDescription: 'Channel untuk notifikasi jadwal shalat',
      importance: Importance.max,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      autoCancel: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(0, title, body, notificationDetails);

    _playAdzanSound();
  }

  static Future<void> _playAdzanSound() async {
    // Pastikan hanya ada satu instance audio yang berjalan
    await _audioPlayer.stop(); // Berhenti jika ada audio lain
    _audioPlayer = AudioPlayer(); // Reinisialisasi audio player
    await _audioPlayer.play(AssetSource('audio/adzan.mp3'));
  }

  static Future<void> stopAdzanSound() async {
    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.stop(); // Pastikan audio benar-benar berhenti
    }
  }

  static Future<void> cancelNotification() async {
    // Hapus notifikasi dan hentikan audio adzan
    await _notificationsPlugin.cancel(0);
    await stopAdzanSound();
  }
}
