import 'package:flutter/material.dart';
import 'package:movie_search/widgets/movie_poster_with_basic_details.dart';

import '../constants/custom_size.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> movie; // Using Map for movie details

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['Title']), // Display the movie title in the app bar
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            MoviePosterWithBasicDetails(movie: movie),
            const SizedBox(height: 10), // Spacing
            Expanded(
              child: ListView.builder(
                itemCount: movie.length,
                itemBuilder: (context, index) {
                  String key = movie.keys.elementAt(index);
                  String value = movie[key].toString();

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.20),
                            offset: const Offset(5.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          key,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: CustomFontWeight.bold),
                        ),
                        // Display the detail title
                        subtitle: Text(value), // Display the detail value
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
