import 'dart:async';
import 'movie_api_provider.dart';
import '../models/item_model.dart';

// This Repository class is the central point from where the data will flow to the BLOC.
class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();
}
