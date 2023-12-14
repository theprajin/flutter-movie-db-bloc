import 'dart:convert';

import 'package:flutter_movie_db_bloc/data/data_provider/popular_api_provider.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

class PopularAPIRepository {
  final PopularAPIProvider popularAPIProvider;

  PopularAPIRepository(this.popularAPIProvider);

  Future<MovieModel> getPopularMovies() async {
    try {
      final popularMovies = await popularAPIProvider.getPopularMovies();

      final data = jsonDecode(popularMovies);

      return MovieModel.fromJson(data);
    } catch (e) {
      print('repository error: ${e.toString()}');
      throw e.toString();
    }
  }
}
