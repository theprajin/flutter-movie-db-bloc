part of 'upcoming_bloc.dart';

@immutable
sealed class UpcomingState {}

final class UpcomingInitial extends UpcomingState {}

final class UpcomingSuccess extends UpcomingState {
  final MovieModel movieModel;

  UpcomingSuccess(this.movieModel);
}

final class UpcomingFailure extends UpcomingState {
  final String error;

  UpcomingFailure(this.error);
}

final class UpcomingLoading extends UpcomingState {}
