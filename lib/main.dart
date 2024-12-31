import 'package:alquran_plus/screen/alquran_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        primaryColor: const Color(0xFF00BFA5),
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
