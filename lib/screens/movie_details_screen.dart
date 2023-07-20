import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/api_constant.dart';
import '../providers/movie_provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "/movie-details";

  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context)?.settings.arguments as int;

    final movieProvider = Provider.of<MovieProvider>(context);
    final movie = movieProvider.findById(movieId);
    final releaseDate = DateTime.parse(movie.releaseDate.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title!),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  imageUrl:
                      '${ApiConstant.posterImageBaseUrl}${movie.posterPath}',
                  errorWidget: (context, url, error) => const SizedBox(
                    height: 20,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: GestureDetector(
                      child: movie.isFavorite!
                          ? const Icon(Icons.star)
                          : const Icon(Icons.star_border),
                      onTap: () {
                        movieProvider.toggleToFavorite(movie.id!);
                      },
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    movie.title!,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (releaseDate != null) Text(" (${releaseDate.year})")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.overview!,
                style: const TextStyle(color: Colors.black87),
              ),
            )
          ],
        ),
      ),
    );
  }
}
