part of 'top_bloc.dart';

@immutable
sealed class TopState {
  final List<Results>? movies;

  TopState([this.movies]);
}

final class TopInitial extends TopState {}

final class TopSuccess extends TopState {
  final List<Results> movies;

  TopSuccess(this.movies);
}

final class TopFailure extends TopState {
  final String error;

  TopFailure(this.error);
}

final class TopLoading extends TopState {}

final class TopLoadMoreSuccess extends TopState {
  final List<Results> movies;

  TopLoadMoreSuccess(this.movies);
}
