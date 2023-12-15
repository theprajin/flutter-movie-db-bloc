part of 'upcoming_bloc.dart';

@immutable
sealed class UpcomingEvent {}

final class UpcomingFetched extends UpcomingEvent {}

final class UpcomingLoadMore extends UpcomingEvent {}
