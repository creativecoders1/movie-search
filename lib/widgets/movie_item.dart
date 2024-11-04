// components/movie_item.dart
import 'package:flutter/material.dart';
import '../constants/custom_size.dart';
import '../constants/custome_colors.dart';
import '../models/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 8),
      width: double.infinity,
      height: screenHeight * 0.27,

      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100.0, right: 10,bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            width: double.infinity,
            height: screenHeight * 0.17,
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  offset: const Offset(5.0, 4.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: screenWidth * 0.37),
                Flexible(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          movie.title,
                          style: TextStyle(
                              fontSize: CustomFontSize.medium,
                              fontWeight: CustomFontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          movie.genre.replaceAll(",", " |"),
                          style: TextStyle(
                              color: Colors.grey, fontSize: CustomFontSize.small),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 20,
                        width: 70,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (double.tryParse(movie.rating) ?? 0) >= 7.0
                                  ? CustomColors.green
                                  : (double.tryParse(movie.rating) ?? 0) >= 4.0
                                      ? CustomColors.blue
                                      : Colors.red),
                          child: Center(
                            child: Text(
                              '${movie.rating.split("/")[0]} IMDB',
                              style: TextStyle(
                                  fontSize: CustomFontSize.small,
                                  fontWeight: CustomFontWeight.semiBold,
                                  color: CustomColors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (movie.poster != "N/A")
            Positioned(
              bottom: 9,
              left: 3.0,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                width: screenWidth * .34,
                height: screenHeight * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.softBlack,
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    movie.poster,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
