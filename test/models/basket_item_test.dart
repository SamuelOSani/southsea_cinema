import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  test('Two cinema tickets cost twice the ticket price', () {
    const movie = Movie(
      id: 'weapons-2025',
      title: 'Weapons (2025)',
      description: 'Horror film',
      ageRating: '18',
      showtime: '21:00',
      ticketPrice: 6.50,
      posterPath: 'assets/images/weapons.jpg',
    );

    const item = BasketItem(movie: movie, quantity: 2);

    expect(item.quantity, 2);
    expect(item.lineTotal, 13.00);
  });
}