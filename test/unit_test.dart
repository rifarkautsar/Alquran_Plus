import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alquran_plus/widget/custom_searchbar.dart';

void main() {
  testWidgets('CustomSearchBar memanggil onSearch dengan nilai yang benar',
      (WidgetTester tester) async {
    String searchValue = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomSearchBar(
            onSearch: (value) {
              searchValue = value;
            },
          ),
        ),
      ),
    );

    // Mengetuk ikon pencarian untuk memperluas input
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Memasukkan teks ke dalam TextField
    await tester.enterText(find.byType(TextField), 'Al-Fatiha');
    await tester.pumpAndSettle();

    // Memastikan onSearch dipanggil dengan nilai yang benar
    expect(searchValue, 'Al-Fatiha');

    // Mengetuk ikon close untuk menutup input
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Memastikan onSearch dipanggil dengan string kosong
    expect(searchValue, '');
  });
}
