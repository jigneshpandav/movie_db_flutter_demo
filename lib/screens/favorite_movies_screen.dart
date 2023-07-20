import 'package:flutter/material.dart';
import 'package:moviedb_demo/widgets/favorite_movies_list.dart';
import 'package:moviedb_demo/widgets/movies_list.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  static const String routeName = "/favorite-movies";

  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        backgroundColor: Colors.black,
      ),
      body: FavoriteMoviesList(),
    );
  }
}
