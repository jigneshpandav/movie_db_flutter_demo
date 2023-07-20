import 'package:flutter/material.dart';
import 'package:moviedb_demo/providers/movie_provider.dart';
import 'package:moviedb_demo/screens/favorite_movies_screen.dart';
import 'package:moviedb_demo/screens/movie_details_screen.dart';
import 'package:moviedb_demo/screens/movies_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
        ),
      ],
      child: const MyMovieApp(),
    ),
  );
}

class MyMovieApp extends StatelessWidget {
  const MyMovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        MoviesScreen.routeName: (context) => const MoviesScreen(),
        MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen(),
        FavoriteMoviesScreen.routeName: (context) =>
            const FavoriteMoviesScreen()
      },
      initialRoute: MoviesScreen.routeName,
    );
  }
}
