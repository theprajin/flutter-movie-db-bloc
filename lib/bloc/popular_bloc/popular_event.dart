part of 'popular_bloc.dart';

@immutable
sealed class PopularEvent {}

final class PopularFetched extends PopularEvent {}

final class PopularLoadMore extends PopularEvent {}
