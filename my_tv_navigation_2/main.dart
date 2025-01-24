import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navigation/widgets/tv_focusable.dart';
import 'pages/home_page.dart';
import 'pages/movies_page.dart';
import 'pages/tv_channels_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Force landscape orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Hide system overlays for TV mode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
    overlays: [],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TVFocusableApp(
      child: MaterialApp(
        title: 'TV App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.purple,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            primary: Colors.purple,
            secondary: Colors.purpleAccent,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final _pages = [
    const HomePage(),
    const MoviesPage(),
    const TVChannelsPage(),
  ];

  final _menuItems = const [
    (icon: Icons.home_outlined, label: 'Home'),
    (icon: Icons.movie_outlined, label: 'Movies'),
    (icon: Icons.tv_outlined, label: 'TV Channels'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Sidebar
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(5, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Logo
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'TV App',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Navigation Items
                for (var i = 0; i < _menuItems.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: TVFocusable(
                      focusKey: 'menu_$i',
                      upFocusKey: i > 0 ? 'menu_${i - 1}' : null,
                      downFocusKey:
                          i < _menuItems.length - 1 ? 'menu_${i + 1}' : null,
                      rightFocusKey: 'content',
                      autofocus: i == 0,
                      onSelect: () {
                        setState(() => _selectedIndex = i);
                      },
                      focusScale: 1.1,
                      focusColor: Colors.purple,
                      selectedColor: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(12),
                      focusPadding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            _menuItems[i].icon,
                            color: _selectedIndex == i
                                ? Colors.purple
                                : Colors.white,
                            size: 28,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _menuItems[i].label,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _selectedIndex == i
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (_selectedIndex == i) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Content Area
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
