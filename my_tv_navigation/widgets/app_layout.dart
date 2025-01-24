import 'package:flutter/material.dart';
import 'main_content.dart';
import 'sidebar.dart';

import '../pages/cinema_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/tv_shows_page.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final List<Widget> pages = [
    const HomePage(),
    const CinemaPage(),
    const TvShowsPage(),
    const ProfilePage(),
  ];
  int currentPage = 0;

  void updatePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(onPageSelected: updatePage),
          Expanded(
            child: MainContent(child: pages[currentPage]),
          )
        ],
      ),
    );
  }
}
