import 'package:alquran_plus/screen/waktu_sholat_page.dart';
import 'package:alquran_plus/widget/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alquran_plus/screen/alquran_page.dart';

void main() {
  testWidgets('Navigasi ke halaman Al-Quran', (WidgetTester tester) async {
    // Build widget dengan Menu
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(), // Tambahkan AppBar untuk memunculkan drawer icon
          drawer: Menu(),
        ),
      ),
    );

    // Buka drawer
    expect(find.byTooltip('Open navigation menu'), findsOneWidget);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    // Tap pada menu Al-Quran
    await tester.tap(find.text('Al-Quran'));
    await tester.pumpAndSettle();

    // Pastikan halaman yang ditampilkan adalah AlquranPage
    expect(find.byType(AlquranPage), findsOneWidget);
  });

  testWidgets('Navigasi ke halaman Waktu Shalat', (WidgetTester tester) async {
    // Build widget dengan Menu
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(), // Tambahkan AppBar untuk memunculkan drawer icon
          drawer: Menu(),
        ),
      ),
    );

    // Buka drawer
    expect(find.byTooltip('Open navigation menu'), findsOneWidget);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    // Tap pada menu Al-Quran
    await tester.tap(find.text('Waktu Shalat'));
    await tester.pumpAndSettle();

    // Pastikan halaman yang ditampilkan adalah AlquranPage
    expect(find.byType(WaktuSholatPage), findsOneWidget);
  });
}
