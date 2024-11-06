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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(
            color: CustomColors.black,
            fontWeight: CustomFontWeight.bold,
            fontSize: CustomFontSize.big,
          ),
        ),
      ),
      body: Container(
        padding:  const EdgeInsets.symmetric(horizontal: 17.0,vertical: 10),
        color: Colors.white,
        child: Column(
          children: [
            TextField(
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
                  borderRadius: BorderRadius.circular(30)

                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)

                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)

                ),
                hintText: "Search",
                prefixIcon: Icon(Icons.movie_filter_outlined),
                hintStyle: TextStyle(
                  fontSize: CustomFontSize.medium,
                  color: CustomColors.softBlack,
                  fontWeight: CustomFontWeight.medium,
                ),
                suffixIcon: IconButton(
                  padding: const EdgeInsets.only(right: 15),
                  icon: Icon(
                    Icons.search,
                    color: CustomColors.softBlack,
                  ),
                  onPressed: () {
                    setState(() {
                      searchText = searchController.text;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: MovieService().searchMovies(searchText),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No movies found'));
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
                                builder: (context) => MovieDetailsScreen(movie: movie), // Pass map
                              ),
                            );
                          },
                          child: MoviePosterWithBasicDetails(movie: movie), // Pass map
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
