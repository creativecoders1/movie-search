import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  final MovieService _movieService = MovieService();

  List<Movie> get movies => _movies;

  Future<void> searchMovies(String keyword) async {
    try {
      _movies = await _movieService.searchMovies(keyword);
      notifyListeners();
    } catch (error) {
      print("Error: $error");
    }
  }
}
