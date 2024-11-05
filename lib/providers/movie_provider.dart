import 'package:flutter/material.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  List<Map<String, dynamic>> _movies = []; // Change to a list of maps
  final MovieService _movieService = MovieService();

  List<Map<String, dynamic>> get movies => _movies; // Update getter

  Future<void> searchMovies(String keyword) async {
    try {
      _movies = await _movieService.searchMovies(keyword); // Update to fetch maps
      notifyListeners();
    } catch (error) {
      print("Error: $error");
    }
  }
}
