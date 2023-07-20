import 'package:flutter/material.dart';
import 'package:moviedb_demo/screens/favorite_movies_screen.dart';
import 'package:moviedb_demo/widgets/movies_list.dart';

class MoviesScreen extends StatelessWidget {
  static const String routeName = "/movies";

  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
            child: const Icon(Icons.star),
            onTap: () {
              Navigator.of(context).pushNamed(FavoriteMoviesScreen.routeName);
            },
          ),
        ],
      ),
      body: MoviesList(),
    );
  }
}
