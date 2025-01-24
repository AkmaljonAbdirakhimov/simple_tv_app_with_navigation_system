import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/home_page.dart';
import 'nav_item.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 0;
  int _focusedIndex = 0;
  bool _isSidebarFocused = true;

  static const _navItems = [
    (icon: Icons.home_outlined, label: 'Home'),
    (icon: Icons.movie_outlined, label: 'Cinema'),
    (icon: Icons.tv_outlined, label: 'TV Channels'),
    (icon: Icons.person_outline, label: 'Profile'),
    (icon: Icons.settings_outlined, label: 'Settings'),
  ];

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;

    setState(() {
      if (_isSidebarFocused) {
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowUp:
            if (_focusedIndex > 0) {
              _focusedIndex--;
            }
            break;
          case LogicalKeyboardKey.arrowDown:
            if (_focusedIndex < _navItems.length - 1) {
              _focusedIndex++;
            }
            break;
          case LogicalKeyboardKey.enter:
          case LogicalKeyboardKey.select:
            _selectedIndex = _focusedIndex;
            _isSidebarFocused = false;
            break;
          case LogicalKeyboardKey.arrowRight:
            _isSidebarFocused = false;
            break;
          default:
            break;
        }
      } else {
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          _isSidebarFocused = true;
        }
      }
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      default:
        return const Center(
          child: Text(
            'Coming Soon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Row(
          children: [
            // Navigation Sidebar
            Container(
              width: 280,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: _isSidebarFocused
                        ? Colors.purple.withOpacity(0.2)
                        : Colors.purple.withOpacity(0.1),
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
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Navigation Items
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: _navItems.length,
                      itemBuilder: (context, index) {
                        final item = _navItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: NavItem(
                            icon: item.icon,
                            label: item.label,
                            isSelected: _selectedIndex == index,
                            isFocused:
                                _isSidebarFocused && _focusedIndex == index,
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                                _focusedIndex = index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: _getPage(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
