import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository unit tests', () {
    test('getMovies returns two movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovies contains the correct movie data', () {
      final repository = MovieRepository();
      final movies = repository.getMovies();

      final weapons = movies[0];

      expect(weapons.id, 'weapons-2025');
      expect(weapons.title, 'Weapons (2025)');
      expect(weapons.ticketPrice, 6.50);
      expect(weapons.posterPath, isNotEmpty);

      final digger = movies[1];

      expect(digger.id, 'digger-2026');
      expect(digger.title, 'Digger (2026)');
      expect(digger.ticketPrice, 6.50);
      expect(digger.posterPath, isNotEmpty);
    });

    test('getMovieById returns an existing movie', () {
      final repository = MovieRepository();

      final Movie? movie = repository.getMovieById('weapons-2025');

      expect(movie, isNotNull);
      expect(movie?.title, 'Weapons (2025)');
      expect(movie?.ticketPrice, 6.50);
    });

    test('getMovieById returns null for an unknown ID', () {
      final repository = MovieRepository();

      final Movie? movie = repository.getMovieById('unknown-movie');

      expect(movie, isNull);
    });
  });
}
