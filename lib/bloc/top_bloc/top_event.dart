part of 'top_bloc.dart';

@immutable
sealed class TopEvent {}

final class TopFetched extends TopEvent {}

final class TopLoadMore extends TopEvent {}
