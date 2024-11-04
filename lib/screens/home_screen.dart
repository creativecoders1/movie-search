// screens/movies_app_home.dart
import 'package:flutter/material.dart';
import 'package:movie_search/constants/custom_size.dart';
import '../constants/custome_colors.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

import '../widgets/movie_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final searchController = TextEditingController();
  String searchText = 'marvel'; //default search for interesting HomePage UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          'Home',
          style: TextStyle(
              color: CustomColors.black,
              fontWeight: CustomFontWeight.bold,
              fontSize: CustomFontSize.big),
        ),
      ),
      body: Container(
        color: Colors.black12,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
              child: TextField(
                onSubmitted: (context) {
                  setState(() {
                    searchText = searchController.text;
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.zero
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                      fontSize: CustomFontSize.medium,
                      color: CustomColors.softBlack,
                      fontWeight: CustomFontWeight.medium),
                  suffixIcon: IconButton(
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
            ),
            Expanded(
              child: FutureBuilder<List<Movie>>(
                future: MovieService().searchMovies(searchText),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  } else {
                    return MovieList(movies: snapshot.data!);
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
