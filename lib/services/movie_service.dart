import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

const String apiKey = '37035275';
const String apiUrl = 'http://www.omdbapi.com/?apikey=';

class MovieService {
  Future<List<Movie>> searchMovies(String keyword) async {
    final response = await http.get(Uri.parse('$apiUrl$apiKey&s=$keyword'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == "True") {
        List movies = data['Search'];

        // Fetch full details for each movie
        List<Movie> movieDetails = [];
        for (var movieJson in movies) {
          String imdbID = movieJson['imdbID'];
          final movieDetail = await getMovieDetails(imdbID);
          movieDetails.add(movieDetail);
        }
        return movieDetails;
      } else {
        throw Exception(data['Error']);
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<Movie> getMovieDetails(String imdbID) async {
    final response = await http.get(Uri.parse('$apiUrl$apiKey&i=$imdbID'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == "True") {
        return Movie.fromJson(data);
      } else {
        throw Exception(data['Error']);
      }
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
