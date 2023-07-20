import 'package:flutter/material.dart';
import 'package:moviedb_demo/widgets/movies_list_item.dart';
import 'package:provider/provider.dart';

import '../providers/movie_provider.dart';

class MoviesList extends StatelessWidget {
  MoviesList({Key? key}) : super(key: key);

  late int pageSize = 1;
  late int totalPages = 1;

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    pageSize = movieProvider.pageSize;
    totalPages = movieProvider.totalPages;

    return GridView.builder(
      itemCount: movieProvider.movies?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        final movie = movieProvider.movies![index];

        return MoviesListItem(movie: movie);

        // return Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Card(
        //     child: Padding(
        //       padding: const EdgeInsets.all(4.0),
        //       child: Image.network(
        //         '${ApiConstant.posterImageBaseUrl}${movie.posterPath}',
        //         fit: BoxFit.fill,
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }
}
