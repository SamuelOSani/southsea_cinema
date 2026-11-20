import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

void main() {
  final BasketRepository basket = BasketRepository.instance;

  setUp(() {
    rootBundle.clear();
    basket.clear();
  });

  tearDown(() {
    basket.clear();
  });

  testWidgets('JSON movie booking, remove and demo checkout work together',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    // The home page's film cards now come from movies.json.
    expect(find.text('Weapons (2025)'), findsOneWidget);
    expect(find.text('Digger (2026)'), findsOneWidget);

    // Add one Weapons ticket from the first film's booking screen.
    await tester.tap(find.text('Book Now').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to order'));
    await tester.pump();
    expect(basket.items.single.movie.id, 'weapons-2025');

    // Return home, then add one Digger ticket too.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Book Now').last);
    await tester.tap(find.text('Book Now').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to order'));
    await tester.pump();
    expect(basket.items.length, 2);
    expect(basket.total, 13.00);

    // Navigate to the basket and remove Weapons, leaving Digger.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Basket'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Remove Weapons (2025)'));
    await tester.pump();
    expect(basket.items.length, 1);
    expect(basket.items.single.movie.id, 'digger-2026');
    expect(basket.total, 6.50);

    // Demo checkout must clear the in-memory basket.
    await tester.tap(find.text('Checkout'));
    await tester.pump();
    expect(basket.items, isEmpty);
    expect(basket.total, 0.0);
    expect(find.text('Your basket is empty.'), findsOneWidget);
    expect(find.text('Demo checkout complete: £6.50'), findsOneWidget);
  });
}
