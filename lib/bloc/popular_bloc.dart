import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie_db_bloc/data/repository/popular_api_repository.dart';
import 'package:flutter_movie_db_bloc/models/movie_model.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final PopularAPIRepository popularAPIRepository;
  PopularBloc(this.popularAPIRepository) : super(PopularInitial()) {
    on<PopularEvent>(_getPopularMovies);
  }

  void _getPopularMovies(PopularEvent event, Emitter<PopularState> emit) async {
    emit(PopularLoading());
    try {
      final popularMovies = await popularAPIRepository.getPopularMovies();
      emit(PopularSuccess(popularMovies));
    } catch (e) {
      emit(PopularFailure(e.toString()));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
