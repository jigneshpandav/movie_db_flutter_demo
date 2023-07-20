import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/api_constant.dart';
import '../providers/movie_provider.dart';

class FavoriteMoviesList extends StatelessWidget {
  FavoriteMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return ListView.builder(
      itemCount: movieProvider.favoriteMovies.length,
      itemBuilder: (context, index) {
        final movie = movieProvider.favoriteMovies![index];
        return Dismissible(
          key: ValueKey(movie.id),
          onDismissed: (direction) {
            movieProvider.toggleToFavorite(movie.id!);
          },
          child: ListTile(
            leading: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl: '${ApiConstant.posterImageBaseUrl}${movie.posterPath}',
              errorWidget: (context, url, error) => const SizedBox(
                height: 20,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            title: Text(movie.title!),
          ),
        );
      },
    );
  }
}
