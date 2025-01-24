import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/movies_screen.dart';
import '../screens/tv_shows_screen.dart';
import 'focusable_item.dart';

class NavigationItemFocusNodes {
  static final FocusNode home = FocusNode();
  static final FocusNode movies = FocusNode();
  static final FocusNode tvShows = FocusNode();
}

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final FocusScopeNode _rootFocusNode = FocusScopeNode();
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomeScreen(),
      MoviesScreen(),
      TVShowsScreen(),
    ];
  }

  @override
  void dispose() {
    _rootFocusNode.dispose();
    NavigationItemFocusNodes.home.dispose();
    NavigationItemFocusNodes.movies.dispose();
    NavigationItemFocusNodes.tvShows.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FocusScope(
        node: _rootFocusNode,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar
            Container(
              width: 200,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  FocusableItem(
                    focusNode: NavigationItemFocusNodes.home,
                    onFocus: (isFocused) {
                      if (isFocused) {
                        setState(() {
                          _currentIndex = 0;
                        });
                      }
                    },
                    autofocus: true,
                    child: const Text('Home'),
                  ),
                  const SizedBox(height: 16),
                  FocusableItem(
                    focusNode: NavigationItemFocusNodes.movies,
                    onFocus: (isFocused) {
                      if (isFocused) {
                        setState(() {
                          _currentIndex = 1;
                        });
                      }
                    },
                    child: const Text('Movies'),
                  ),
                  const SizedBox(height: 16),
                  FocusableItem(
                    focusNode: NavigationItemFocusNodes.tvShows,
                    onFocus: (isFocused) {
                      if (isFocused) {
                        setState(() {
                          _currentIndex = 2;
                        });
                      }
                    },
                    child: const Text('TV Shows'),
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: _screens[_currentIndex],
            ),
          ],
        ),
      ),
    );
  }
}
