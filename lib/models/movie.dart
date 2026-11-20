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

  factory Movie.fromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    ageRating: json['ageRating'] as String,
    showtime: json['showtime'] as String,
    ticketPrice: (json['ticketPrice'] as num).toDouble(),
    posterPath: json['posterPath'] as String,
  );
}

Map<String, dynamic> toJson() {
  return <String, dynamic>{
    'id': id,
    'title': title,
    'description': description,
    'ageRating': ageRating,
    'showtime': showtime,
    'ticketPrice': ticketPrice,
    'posterPath': posterPath,
  };
}

  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}';
}
