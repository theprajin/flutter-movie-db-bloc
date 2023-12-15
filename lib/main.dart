import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db_bloc/bloc/popular_bloc.dart';
import 'package:flutter_movie_db_bloc/bloc/top_bloc/top_bloc.dart';
import 'package:flutter_movie_db_bloc/bloc/upcoming_bloc/upcoming_bloc.dart';

import 'package:flutter_movie_db_bloc/data/data_provider/popular_api_provider.dart';
import 'package:flutter_movie_db_bloc/data/data_provider/top_api_provider.dart';
import 'package:flutter_movie_db_bloc/data/data_provider/upcomint_api_provider.dart';
import 'package:flutter_movie_db_bloc/data/repository/movie_api_repository.dart';
import 'package:flutter_movie_db_bloc/data/repository/popular_api_repository.dart';
import 'package:flutter_movie_db_bloc/data/repository/top_api_repository.dart';
import 'package:flutter_movie_db_bloc/data/repository/upcoming_api_repository.dart';
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
        ),
        RepositoryProvider(
          create: (context) => UpcomingAPIRepository(UpcomingAPIProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PopularBloc(
                    context.read<PopularAPIRepository>(),
                  )),
          BlocProvider(
              create: (context) => TopBloc(context.read<MovieAPIRepository>())),
          BlocProvider(
              create: (context) =>
                  UpcomingBloc(context.read<UpcomingAPIRepository>())),
        ],
        child: MaterialApp(
          title: 'Movie DB',
          debugShowCheckedModeBanner: false,
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
