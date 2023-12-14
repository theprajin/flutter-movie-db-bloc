import 'dart:convert';

import 'package:flutter_movie_db_bloc/data/data_provider/upcomint_api_provider.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

class UpcomingAPIRepository {
  final UpcomingAPIProvider upcomingAPIProvider;

  UpcomingAPIRepository(this.upcomingAPIProvider);

  Future<MovieModel> getUpcomingMovies() async {
    try {
      final topMovies = await upcomingAPIProvider.getUpcomingMovies();

      final data = jsonDecode(topMovies);

      return MovieModel.fromJson(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
