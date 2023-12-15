part of 'upcoming_bloc.dart';

@immutable
sealed class UpcomingState {
  final List<Results>? movies;

  UpcomingState([this.movies]);
}

final class UpcomingInitial extends UpcomingState {}

final class UpcomingSuccess extends UpcomingState {
  final List<Results> movies;

  UpcomingSuccess(this.movies);
}

final class UpcomingFailure extends UpcomingState {
  final String error;

  UpcomingFailure(this.error);
}

final class UpcomingLoading extends UpcomingState {}

final class UpcomingLoadMoreSuccess extends UpcomingState {
  final List<Results> movies;

  UpcomingLoadMoreSuccess(this.movies);
}
