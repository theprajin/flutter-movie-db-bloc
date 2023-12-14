part of 'top_bloc.dart';

@immutable
sealed class TopState {}

final class TopInitial extends TopState {}

final class TopSuccess extends TopState {
  final MovieModel movieModel;

  TopSuccess(this.movieModel);
}

final class TopFailure extends TopState {
  final String error;

  TopFailure(this.error);
}

final class TopLoading extends TopState {}
