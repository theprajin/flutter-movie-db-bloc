import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie_db_bloc/data/repository/top_api_repository.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

part 'top_event.dart';
part 'top_state.dart';

class TopBloc extends Bloc<TopEvent, TopState> {
  final TopAPIRepository topAPIRepository;
  TopBloc(this.topAPIRepository) : super(TopInitial()) {
    on<TopEvent>(_getTopMovies);
  }

  void _getTopMovies(
    TopEvent event,
    Emitter<TopState> emit,
  ) async {
    emit(TopLoading());
    try {
      final topMovies = await topAPIRepository.getTopMovies();
      emit(TopSuccess(topMovies));
    } catch (e) {
      emit(TopFailure(e.toString()));
    }
  }
}
