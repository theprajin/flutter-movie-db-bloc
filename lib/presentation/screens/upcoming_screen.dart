import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_movie_db_bloc/bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:flutter_movie_db_bloc/constants/const_widgets.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UpcomingBloc>().add(UpcomingFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingBloc, UpcomingState>(
      builder: (context, state) {
        if (state is UpcomingFailure) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is UpcomingSuccess || state is UpcomingLoadMoreSuccess) {
          final data = state.movies;

          return NotificationListener(
            onNotification: (ScrollEndNotification onNotification) {
              final before = onNotification.metrics.extentBefore;
              final max = onNotification.metrics.maxScrollExtent;
              if (before == max) {
                context.read<UpcomingBloc>().add(UpcomingLoadMore());
              }
              return true;
            },
            child: GridView.builder(
                itemCount: data?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  final movie = data![index];

                  return CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original${movie.posterPath ?? ''}',
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                    placeholder: (context, url) => dualRing,
                  );
                }),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
