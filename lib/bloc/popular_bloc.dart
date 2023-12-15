import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie_db_bloc/data/repository/movie_api_repository.dart';

import 'package:flutter_movie_db_bloc/models/movie_model.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final MovieAPIRepository movieAPIRepository;
  int page = 1;
  List<Results> movieList = [];

  PopularBloc(this.movieAPIRepository) : super(PopularInitial()) {
    on<PopularFetched>(_getPopularMovies);
    on<PopularLoadMore>(_loadMorePopularMovies);
  }

  void _getPopularMovies(
    PopularFetched event,
    Emitter<PopularState> emit,
  ) async {
    emit(PopularLoading());
    try {
      movieList.clear();
      final popularMovies =
          await movieAPIRepository.getPopularMovies(pathQuery: "popular");
      movieList = [...movieList, ...popularMovies!];
      emit(PopularSuccess(popularMovies));
    } catch (e) {
      emit(PopularFailure(e.toString()));
    }
  }

  void _loadMorePopularMovies(
    PopularLoadMore event,
    Emitter<PopularState> emit,
  ) async {
    page++;
    try {
      final popularMovies = await movieAPIRepository.getPopularMovies(
        page: page,
        pathQuery: 'popular',
      );
      movieList = [...movieList, ...popularMovies!];
      emit(PopularLoadMoreSuccess(movieList));
    } catch (e) {
      emit(PopularFailure(e.toString()));
    }
  }
}
