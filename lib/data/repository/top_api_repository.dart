import 'dart:convert';

import 'package:flutter_movie_db_bloc/data/data_provider/top_api_provider.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

class TopAPIRepository {
  final TopAPIProvider topAPIProvider;

  TopAPIRepository(this.topAPIProvider);

  Future<MovieModel> getTopMovies() async {
    try {
      final topMovies = await topAPIProvider.getTopMovies();

      final data = jsonDecode(topMovies);

      return MovieModel.fromJson(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
