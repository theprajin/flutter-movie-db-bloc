import 'dart:convert';

import 'package:flutter_movie_db_bloc/data/data_provider/movie_api_provider.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

class MovieAPIRepository {
  final MovieAPIProvider movieAPIProvider;

  MovieAPIRepository(this.movieAPIProvider);

  Future<List<Results>?> getPopularMovies(
      {int page = 1, required String pathQuery}) async {
    try {
      final popularMovies = await movieAPIProvider.getPopularMovies(
          page: page, pathQuery: pathQuery);

      final data = jsonDecode(popularMovies);

      return MovieModel.fromJson(data).results;
    } catch (e) {
      print('repository error: ${e.toString()}');
      throw e.toString();
    }
  }
}
