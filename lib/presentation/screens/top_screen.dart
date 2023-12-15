import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db_bloc/bloc/top_bloc/top_bloc.dart';
import 'package:flutter_movie_db_bloc/constants/const_widgets.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<TopScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TopBloc>().add(TopFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopBloc, TopState>(
      builder: (context, state) {
        if (state is TopFailure) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is TopSuccess || state is TopLoadMoreSuccess) {
          final data = state.movies;

          return NotificationListener(
            onNotification: (ScrollEndNotification onNotification) {
              final before = onNotification.metrics.extentBefore;
              final max = onNotification.metrics.maxScrollExtent;
              if (before == max) {
                context.read<TopBloc>().add(TopLoadMore());
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
