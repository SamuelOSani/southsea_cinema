import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('Movie stores the correct properties', () {
      const movie = Movie(
        id: 'weapons-2025',
        title: 'Weapons (2025)',
        description: 'A mystery horror film',
        ageRating: '18',
        showtime: '21:00',
        ticketPrice: 6.50,
        posterPath: 'assets/images/weapons.jpg',
      );

      expect(movie.id, 'weapons-2025');
      expect(movie.title, 'Weapons (2025)');
      expect(movie.description, 'A mystery horror film');
      expect(movie.ageRating, '18');
      expect(movie.showtime, '21:00');
      expect(movie.ticketPrice, 6.50);
      expect(movie.posterPath, 'assets/images/weapons.jpg');
    });

    test('formattedPrice displays two decimal places', () {
      const movieWithPence = Movie(
        id: 'test-1',
        title: 'Test Movie',
        description: 'A test description',
        ageRating: '15',
        showtime: '19:00',
        ticketPrice: 6.50,
        posterPath: 'assets/images/weapons.jpg',
      );

      const movieWithWholePounds = Movie(
        id: 'test-2',
        title: 'Test Movie 2',
        description: 'Another test description',
        ageRating: '12',
        showtime: '20:00',
        ticketPrice: 10.00,
        posterPath: 'assets/images/weapons.jpg',
      );

      expect(movieWithPence.formattedPrice, '£6.50');
      expect(movieWithWholePounds.formattedPrice, '£10.00');
    });
  });
}
