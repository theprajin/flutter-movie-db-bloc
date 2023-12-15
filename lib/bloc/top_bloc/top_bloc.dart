import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie_db_bloc/data/repository/movie_api_repository.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

part 'top_event.dart';
part 'top_state.dart';

class TopBloc extends Bloc<TopEvent, TopState> {
  final MovieAPIRepository movieAPIRepository;
  int page = 1;
  List<Results> movieList = [];

  TopBloc(this.movieAPIRepository) : super(TopInitial()) {
    on<TopFetched>(_getPopularMovies);
    on<TopLoadMore>(_loadMorePopularMovies);
  }

  void _getPopularMovies(
    TopFetched event,
    Emitter<TopState> emit,
  ) async {
    emit(TopLoading());
    try {
      movieList.clear();
      final popularMovies =
          await movieAPIRepository.getPopularMovies(pathQuery: 'top_rated');
      movieList = [...movieList, ...popularMovies!];
      emit(TopSuccess(popularMovies));
    } catch (e) {
      emit(TopFailure(e.toString()));
    }
  }

  void _loadMorePopularMovies(
    TopLoadMore event,
    Emitter<TopState> emit,
  ) async {
    page++;
    try {
      final popularMovies = await movieAPIRepository.getPopularMovies(
        page: page,
        pathQuery: 'top_rated',
      );
      movieList = [...movieList, ...popularMovies!];
      emit(TopLoadMoreSuccess(movieList));
    } catch (e) {
      emit(TopFailure(e.toString()));
    }
  }
}
