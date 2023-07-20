import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb_demo/constants/api_constant.dart';
import 'package:moviedb_demo/utils/database_helper.dart';

import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  MovieProvider() {
    fetchFavoriteMovies().then(
      (value) {
        fetchMovies();
      },
    );
  }

  int pageSize = 1;
  int totalPages = 1;
  List<Movie> _movies = [];
  List<Movie> _favoriteMovies = [];
  List<int> _favMovieIds = [];

  List<Movie>? get movies {
    List<Movie>? sortedMovies = [..._movies
      ..sort(
          (a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()))];
    return sortedMovies;
  }

  List<Movie> get favoriteMovies {
    return [..._favoriteMovies];
  }

  Future<List<int>> fetchFavoriteMovies() async {
    var fav = await DatabaseHelper.instance.queryAllRows();
    List<int> favMovies = [];
    fav.forEach((element) {
      favMovies.add(element['movie_id']);
    });
    _favMovieIds.addAll(favMovies);
    notifyListeners();
    return favMovies;
  }

  Future<void> fetchMovies() async {
    var url = Uri.parse(
        '${ApiConstant.baseUrl}${ApiConstant.popularMovies}?api_key=${ApiConstant.apiKey}&page=${pageSize + 1}');

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Movie> loadedMovies = [];

      pageSize = data['page'];
      totalPages = data['total_pages'];

      data['results'].forEach((movie) {
        Movie m = Movie.fromJson(movie);
        if (_favMovieIds.contains(m.id)) {
          m.isFavorite = true;
        }
        loadedMovies.add(m);
      });
      _movies.addAll(loadedMovies);
      _favoriteMovies = _movies.where((element) => element.isFavorite == true).toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Movie findById(int movieId) {
    return _movies.firstWhere((movie) => movie.id == movieId);
  }

  toggleToFavorite(int movieId) {
    Movie movie = _movies.firstWhere((movie) => movie.id == movieId);

    if (movie.isFavorite as bool) {
      DatabaseHelper.instance.delete(movieId).then(
        (_) {
          movie.isFavorite = false;
          _favMovieIds.remove(movieId);
          _favoriteMovies.removeWhere((element) => element.id == movieId);
          notifyListeners();
        },
      );
    } else {
      DatabaseHelper.instance.insert(movieId).then(
        (_) {
          movie.isFavorite = true;
          _favMovieIds.add(movieId);
          _favoriteMovies.add(movie);
          notifyListeners();
        },
      );
    }
  }
}
