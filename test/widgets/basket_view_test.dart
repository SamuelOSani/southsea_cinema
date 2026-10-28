import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

void main() {
  final basket = BasketRepository.instance;

  const weapons = Movie(
    id: 'weapons-2025',
    title: 'Weapons (2025)',
    description: 'Horror film',
    ageRating: '18',
    showtime: '21:00',
    ticketPrice: 6.50,
    posterPath: 'assets/images/weapons.jpg',
  );

  const digger = Movie(
    id: 'digger-2026',
    title: 'Digger (2026)',
    description: 'Action film',
    ageRating: '15',
    showtime: '19:30',
    ticketPrice: 6.50,
    posterPath: 'assets/images/digger.jpg',
  );

  setUp(() {
    basket.clear();
  });

  tearDown(() {
    basket.clear();
  });

  testWidgets('Removing one movie keeps the other movie', (tester) async {
    basket.addTickets(weapons, 2);
    basket.addTickets(digger, 1);

    await tester.pumpWidget(
      const MaterialApp(home: BasketView()),
    );

    expect(find.text('Weapons (2025)'), findsOneWidget);
    expect(find.text('Digger (2026)'), findsOneWidget);
    expect(basket.total, 19.50);

    await tester.tap(find.byTooltip('Remove Weapons (2025)'));
    await tester.pump();

    expect(find.text('Weapons (2025)'), findsNothing);
    expect(find.text('Digger (2026)'), findsOneWidget);
    expect(basket.items.length, 1);
    expect(basket.total, 6.50);
  });

  testWidgets('Clear Basket removes all tickets', (tester) async {
    basket.addTickets(weapons, 2);
    basket.addTickets(digger, 1);

    await tester.pumpWidget(
      const MaterialApp(home: BasketView()),
    );

    await tester.tap(find.text('Clear Basket'));
    await tester.pump();

    expect(basket.items, isEmpty);
    expect(basket.total, 0.0);
    expect(find.text('Your basket is empty.'), findsOneWidget);
  });

  testWidgets('Checkout confirms the total and clears the basket',
      (tester) async {
    basket.addTickets(weapons, 2);
    basket.addTickets(digger, 1);

    await tester.pumpWidget(
      const MaterialApp(home: BasketView()),
    );

    expect(find.text('Total: £19.50'), findsOneWidget);

    await tester.tap(find.text('Checkout'));
    await tester.pump();

    expect(basket.items, isEmpty);
    expect(basket.total, 0.0);
    expect(find.text('Your basket is empty.'), findsOneWidget);
    expect(
      find.text('Demo checkout complete: £19.50'),
      findsOneWidget,
    );
  });
}
