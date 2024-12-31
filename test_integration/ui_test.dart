import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:alquran_plus/widget/custom_searchbar.dart'; // Ganti dengan nama paket Anda

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Cek UI Custom Search Bar ', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomSearchBar(
            onSearch: (value) {},
          ),
        ),
      ),
    );

    // Memastikan ikon pencarian terlihat
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Mengetuk ikon pencarian untuk memperluas input
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Memastikan TextField terlihat setelah diperluas
    expect(find.byType(TextField), findsOneWidget);

    // Memasukkan teks ke dalam TextField
    await tester.enterText(find.byType(TextField), 'Al-Fatiha');
    await tester.pumpAndSettle();

    // Memastikan teks yang dimasukkan muncul di TextField
    expect(find.text('Al-Fatiha'), findsOneWidget);

    // Mengetuk ikon close untuk menutup input
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Memastikan TextField tidak terlihat setelah ditutup
    expect(find.byType(TextField), findsNothing);
  });
}
