import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db_bloc/bloc/popular_bloc.dart';

import 'package:flutter_movie_db_bloc/constants/const_widgets.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PopularBloc>().add(PopularFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBloc, PopularState>(builder: (context, state) {
      if (state is PopularFailure) {
        return Center(
          child: Text(state.error),
        );
      }

      if (state is! PopularSuccess) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final data = state.movieModel.results;

      return GridView.builder(
          itemCount: data!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            final movie = data[index];

            return CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/original${movie.posterPath ?? ''}',
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
              placeholder: (context, url) => dualRing,
            );
          });
    });
  }
}
