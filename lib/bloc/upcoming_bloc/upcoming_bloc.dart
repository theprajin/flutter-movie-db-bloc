import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie_db_bloc/data/repository/upcoming_api_repository.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final UpcomingAPIRepository upcomingAPIRepository;
  UpcomingBloc(this.upcomingAPIRepository) : super(UpcomingInitial()) {
    on<UpcomingEvent>(_getUpcomingMovies);
  }

  void _getUpcomingMovies(
    UpcomingEvent event,
    Emitter<UpcomingState> emit,
  ) async {
    emit(UpcomingLoading());
    try {
      final upcomingMovies = await upcomingAPIRepository.getUpcomingMovies();
      emit(UpcomingSuccess(upcomingMovies));
    } catch (e) {
      emit(UpcomingFailure(e.toString()));
    }
  }
}
