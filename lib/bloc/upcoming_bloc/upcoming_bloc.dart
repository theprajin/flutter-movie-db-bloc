import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie_db_bloc/data/repository/movie_api_repository.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final MovieAPIRepository movieAPIRepository;
  int page = 1;
  List<Results> movieList = [];

  UpcomingBloc(this.movieAPIRepository) : super(UpcomingInitial()) {
    on<UpcomingFetched>(_getPopularMovies);
    on<UpcomingLoadMore>(_loadMorePopularMovies);
  }

  void _getPopularMovies(
    UpcomingFetched event,
    Emitter<UpcomingState> emit,
  ) async {
    emit(UpcomingLoading());
    try {
      final popularMovies =
          await movieAPIRepository.getPopularMovies(pathQuery: 'upcoming');
      movieList = [...popularMovies!];
      emit(UpcomingSuccess(popularMovies));
    } catch (e) {
      emit(UpcomingFailure(e.toString()));
    }
  }

  void _loadMorePopularMovies(
    UpcomingLoadMore event,
    Emitter<UpcomingState> emit,
  ) async {
    page++;
    try {
      final popularMovies = await movieAPIRepository.getPopularMovies(
        page: page,
        pathQuery: 'top_rated',
      );
      movieList = [...movieList, ...popularMovies!];
      emit(UpcomingLoadMoreSuccess(movieList));
    } catch (e) {
      emit(UpcomingFailure(e.toString()));
    }
  }
}
