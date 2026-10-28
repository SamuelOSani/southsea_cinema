import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

void main() {
  final basket = BasketRepository.instance;

  const movie = Movie(
    id: 'weapons-2025',
    title: 'Weapons (2025)',
    description: 'Horror film',
    ageRating: '18',
    showtime: '21:00',
    ticketPrice: 6.50,
    posterPath: 'assets/images/weapons.jpg',
  );

  setUp(() {
    basket.clear();
  });

  tearDown(() {
    basket.clear();
  });

  testWidgets('Add to order stores a cinema ticket', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MovieListing(movie: movie),
      ),
    );

    expect(basket.items, isEmpty);

    await tester.ensureVisible(find.text('Add to order'));
    await tester.tap(find.text('Add to order'));
    await tester.pump();

    expect(basket.items.length, 1);
    expect(basket.items.first.movie.id, 'weapons-2025');
    expect(basket.items.first.quantity, 1);
    expect(basket.total, 6.50);

    expect(find.text('1 ticket(s) added to order'), findsOneWidget);
  });

  testWidgets('Selecting two tickets stores the correct quantity',
    (tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: MovieListing(movie: movie),
    ),
  );

  await tester.tap(find.byType(DropdownMenu<int>));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Two tickets').last);
  await tester.pumpAndSettle();

  await tester.ensureVisible(find.text('Add to order'));
  await tester.tap(find.text('Add to order'));
  await tester.pump();

  expect(basket.items.length, 1);
  expect(basket.items.single.quantity, 2);
  expect(basket.total, 13.00);

  expect(find.text('2 ticket(s) added to order'), findsOneWidget);
});
}
