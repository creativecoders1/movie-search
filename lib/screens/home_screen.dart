import 'package:flutter/material.dart';
import 'package:movie_search/constants/custom_size.dart';
import 'package:movie_search/widgets/movie_poster_with_basic_details.dart';
import '../constants/custome_colors.dart';
import '../services/movie_service.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final searchController = TextEditingController();
  String searchText = 'marvel'; // default search for interesting HomePage UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/icon/app_icon.png",
          width: 65,
          height: 65,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent),
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  searchText = value;
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFedf0f9),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "Search for movies",
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Icon(
                    Icons.movie_filter_outlined,
                    color: Colors.grey[600],
                  ),
                ),
                hintStyle: TextStyle(
                  fontSize: CustomFontSize.medium,
                  color: Colors.grey[700],
                  fontWeight: CustomFontWeight.medium,
                ),
                suffixIcon: IconButton(
                  padding: const EdgeInsets.only(right: 15),
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    setState(() {
                      searchText = searchController.text;
                    });
                  },
                ),
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: MovieService().searchMovies(searchText),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Align(
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(((snapshot.error).toString()).substring(
                          10, (snapshot.error).toString().length - 1)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Movie not found!'));
                } else {
                  final List<Map<String, dynamic>> movies = snapshot.data!;
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsScreen(movie: movie), // Pass map
                            ),
                          );
                        },
                        child: MoviePosterWithBasicDetails(
                            movie: movie), // Pass map
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
