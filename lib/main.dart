import 'package:alquran_plus/controllers/audio_controller.dart';
import 'package:alquran_plus/screen/alquran_page.dart';
// import 'package:alquran_plus/widget/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

  // NotificationHelper.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF3DC185),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(),
        ),
      ),
      home: AlquranPage(),
    );
  }
}
