import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_demo/screens/movie_details_screen.dart';
import 'package:provider/provider.dart';
import '../constants/api_constant.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';

class MoviesListItem extends StatelessWidget {
  final Movie movie;

  MoviesListItem({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return GestureDetector(
      onTap: () async {
        Navigator.of(context)
            .pushNamed(MovieDetailsScreen.routeName, arguments: movie.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black12,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    height: double.infinity,
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
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black87,
                child: Text(
                  movie.title!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
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
      ),
    );
  }
}
