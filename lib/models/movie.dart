class Movie {
  final String id;
  final String title;
  final String description;
  final String ageRating;
  final String showtime;
  final double ticketPrice;
  final String posterPath;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.ageRating,
    required this.showtime,
    required this.ticketPrice,
    required this.posterPath,
  });

  String get formattedPrice => 
      '£${ticketPrice.toStringAsFixed(2)}';
}
