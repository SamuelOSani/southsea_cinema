import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets('Drawer navigates between cinema pages', (tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());

    // Navigate from Home to My Basket.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('My Basket'));
    await tester.pumpAndSettle();

    expect(find.text('Your basket is empty.'), findsOneWidget);

    // Navigate from My Basket to My Settings.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('My Settings'));
    await tester.pumpAndSettle();

    expect(
      find.text('Customer settings will appear here.'),
      findsOneWidget,
    );

    // Navigate back to Home.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Weapons (2025)'), findsOneWidget);
  });
}