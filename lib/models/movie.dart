// models/movie.dart
class Movie {
  final String title;
  final String rating; // IMDb rating
  final String genre;  // Movie genre
  final String poster;
  final String released;
  final String type;// Movie poster URL

  Movie( {
    required this.released,
    required this.title,
    required this.rating,
    required this.genre,
    required this.poster,
    required this.type,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'N/A',
      rating: json['imdbRating'] ?? 'N/A',
      genre: json['Genre'] ?? 'N/A',
      poster: json['Poster'] != 'N/A' ? json['Poster'] : '',
      released: json["Released"]?? 'Not Available',
      type: json['Type']?? '',// Empty if no poster available
    );
  }
}
