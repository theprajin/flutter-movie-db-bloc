import 'package:flutter/material.dart';

import 'package:flutter_movie_db_bloc/presentation/screens/popular_screen.dart';
import 'package:flutter_movie_db_bloc/presentation/screens/top_screen.dart';
import 'package:flutter_movie_db_bloc/presentation/screens/upcoming_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _selectPageIndex = 0;

  final List<Widget> _pages = const [
    PopularScreen(),
    TopScreen(),
    UpcomingScreen()
  ];

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectPageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Top',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Upcoming',
          ),
        ],
        currentIndex: _selectPageIndex,
        selectedIconTheme: const IconThemeData(opacity: 0.0, size: 0.0),
        unselectedIconTheme: const IconThemeData(opacity: 0.0, size: 0.0),
        selectedFontSize: 20,
        unselectedFontSize: 17,
        onTap: _selectPage,
      ),
    );
  }
}
