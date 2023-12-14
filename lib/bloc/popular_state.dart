part of 'popular_bloc.dart';

@immutable
sealed class PopularState {}

final class PopularInitial extends PopularState {}

final class PopularSuccess extends PopularState {
  final MovieModel movieModel;

  PopularSuccess(this.movieModel);
}

final class PopularFailure extends PopularState {
  final String error;

  PopularFailure(this.error);
}

final class PopularLoading extends PopularState {}
