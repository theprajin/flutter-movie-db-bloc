import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db_bloc/bloc/popular_bloc.dart';
import 'package:flutter_movie_db_bloc/bloc/top_bloc/top_bloc.dart';
import 'package:flutter_movie_db_bloc/constants/const_widgets.dart';
import 'package:flutter_movie_db_bloc/data/data_provider/popular_api_provider.dart';
import 'package:flutter_movie_db_bloc/data/data_provider/top_api_provider.dart';
import 'package:flutter_movie_db_bloc/data/repository/popular_api_repository.dart';
import 'package:flutter_movie_db_bloc/data/repository/top_api_repository.dart';
import 'package:flutter_movie_db_bloc/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => PopularAPIRepository(PopularAPIProvider())),
        RepositoryProvider(
          create: (context) => TopAPIRepository(TopAPIProvider()),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PopularBloc(
                    context.read<PopularAPIRepository>(),
                  )),
          BlocProvider(
              create: (context) => TopBloc(context.read<TopAPIRepository>()))
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularBloc>().add(PopularFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<PopularBloc, PopularState>(
        builder: (context, state) {
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
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                final movie = data[index];

                return CachedNetworkImage(
                  errorWidget: (c, s, d) =>
                      Image.asset('/assets/image/movie.png'),
                  imageUrl:
                      'https://image.tmdb.org/t/p/original${movie.posterPath ?? ''}',
                  placeholder: (context, url) => dualRing,
                );
              });
        },
      ),
    );
  }
}
