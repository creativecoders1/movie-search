// components/movie_list.dart
import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_item.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieItem(movie: movies[index]);
      },
    );
  }
}
