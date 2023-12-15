part of 'popular_bloc.dart';

@immutable
sealed class PopularState {
  final List<Results>? movies;

  PopularState([this.movies]);
}

final class PopularInitial extends PopularState {}

final class PopularSuccess extends PopularState {
  final List<Results> movies;

  PopularSuccess(this.movies);
}

final class PopularFailure extends PopularState {
  final String error;

  PopularFailure(this.error);
}

final class PopularLoading extends PopularState {}

final class PopularLoadMoreSuccess extends PopularState {
  final List<Results> movies;

  PopularLoadMoreSuccess(this.movies);
}
