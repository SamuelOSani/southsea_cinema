import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: 'weapons-2025',
        title: 'Weapons (2025)',
        description:
            'When all but one child from the same class mysteriously vanish on the same night at exactly the same time, a community is left questioning who or what is behind their disappearance.',
        ageRating: '18',
        showtime: 'Sunday 4th October 2026, 21:00 - ends at 23:08',
        ticketPrice: 6.50,
        posterPath: 'assets/images/weapons.jpg',
      ),
      Movie(
        id: 'digger-2026',
        title: 'Digger (2026)',
        description:
            "The most powerful man in the world embarks on a frantic mission to prove he is humanity's savior before the disaster he's unleashed destroys everything.",
        ageRating: '15',
        showtime: 'Saturday 10th October 2026, 19:30 - ends at 21:40',
        ticketPrice: 6.50,
        posterPath: 'assets/images/digger.jpg',
      )
    ];
  }
}
