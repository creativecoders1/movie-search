import 'package:flutter/material.dart';
import '../widgets/movie_item.dart';

class MovieList extends StatelessWidget {
  final List<Map<String, dynamic>> movies; // Change to list of maps

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieItem(movie: movies[index]); // Pass map
      },
    );
  }
}
