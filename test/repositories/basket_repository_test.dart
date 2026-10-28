import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

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

  test('Adding the same movie combines ticket quantities', () {
    basket.addTickets(movie, 2);
    basket.addTickets(movie, 1);

    expect(basket.items.length, 1);
    expect(basket.items.first.quantity, 3);
    expect(basket.items.first.lineTotal, 19.50);
  });

  test('Removing a movie keeps other basket items', () {
    const digger = Movie(
      id: 'digger-2026',
      title: 'Digger (2026)',
      description: 'Action film',
      ageRating: '15',
      showtime: '19:30',
      ticketPrice: 6.50,
      posterPath: 'assets/images/digger.jpg',
    );

    basket.addTickets(movie, 2);
    basket.addTickets(digger, 1);

    expect(basket.total, 19.50);

    basket.removeMovie('weapons-2025');

    expect(basket.items.length, 1);
    expect(basket.items.first.movie.id, 'digger-2026');
    expect(basket.total, 6.50);
  });

  test('Clearing the basket removes everything', () {
    basket.addTickets(movie, 3);

    basket.clear();

    expect(basket.items, isEmpty);
    expect(basket.total, 0.0);
  });

  test('Cannot add zero or negative tickets', () {
    expect(
      () => basket.addTickets(movie, 0),
      throwsArgumentError,
    );

    expect(
      () => basket.addTickets(movie, -2),
      throwsArgumentError,
    );

    expect(basket.items, isEmpty);
  });

  test('Basket items cannot be modified directly', () {
    basket.addTickets(movie, 2);

    expect(
      () => basket.items.clear(),
      throwsUnsupportedError,
    );

    expect(basket.items.length, 1);
    expect(basket.items.first.quantity, 2);
    expect(basket.total, 13.00);
  });
}
