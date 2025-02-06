import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alquran_plus/widget/menu.dart';
import 'package:alquran_plus/screen/alquran_page.dart';
import 'package:alquran_plus/screen/waktu_sholat_page.dart';
import 'package:alquran_plus/screen/kiblat_page.dart';
import 'package:alquran_plus/screen/aboutus_page.dart';

void main() {
  testWidgets('Menu widget harus menampilkan semua komponen dengan benar',
      (WidgetTester tester) async {
    // Build widget Menu dalam MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          drawer: Menu(),
        ),
      ),
    );

    // Buka drawer dengan mengetuk ikon menu
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    // Verifikasi komponen kalender
    expect(find.text('ASHAR 15:17'), findsOneWidget);

    // Verifikasi semua item menu tersedia
    expect(find.text('Al-Quran'), findsOneWidget);
    expect(find.text('Waktu Sholat'), findsOneWidget);
    expect(find.text('Kiblat'), findsOneWidget);
    expect(find.text('About Us'), findsOneWidget);

    // Verifikasi ikon menu tersedia
    expect(find.byIcon(Icons.menu_book), findsOneWidget);
    expect(find.byIcon(Icons.access_time), findsOneWidget);
    expect(find.byIcon(Icons.explore), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
  });

  testWidgets('Menu harus bisa melakukan navigasi ke Al-Quran',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          drawer: Menu(),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Al-Quran'));
    await tester.pumpAndSettle();

    expect(find.byType(AlquranPage), findsOneWidget);
  });

  testWidgets('Menu harus bisa melakukan navigasi ke Waktu Sholat',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          drawer: Menu(),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Waktu Sholat'));
    await tester.pumpAndSettle();

    expect(find.byType(WaktuSholatPage), findsOneWidget);
  });

  testWidgets('Menu harus bisa melakukan navigasi ke Kiblat',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          drawer: Menu(),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kiblat'));
    await tester.pumpAndSettle();

    expect(find.byType(KiblatCompass), findsOneWidget);
  });

  testWidgets('Menu harus bisa melakukan navigasi ke About Us',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          drawer: Menu(),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('About Us'));
    await tester.pumpAndSettle();

    expect(find.byType(AboutUs), findsOneWidget);
  });
}
