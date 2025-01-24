import 'package:flutter/material.dart';
import 'package:tv_app/widgets/tv_focusable.dart';
import 'nav_item.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onPageSelected;
  const Sidebar({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TVFocusable(
          focusKey: "home",
          downFocusKey: "cinema",
          rightFocusKey: "play",
          autofocus: true,
          onFocused: () => onPageSelected(0),
          child: NavItem(
            title: "Home",
            icon: Icons.home,
            onTap: () => onPageSelected(0),
          ),
        ),
        TVFocusable(
          focusKey: "cinema",
          upFocusKey: "home",
          downFocusKey: "tvshows",
          onFocused: () => onPageSelected(1),
          child: NavItem(
            title: "Cinema",
            icon: Icons.movie,
            onTap: () => onPageSelected(1),
          ),
        ),
        TVFocusable(
          focusKey: "tvshows",
          upFocusKey: "cinema",
          downFocusKey: "profile",
          onFocused: () => onPageSelected(2),
          child: NavItem(
            title: "TV Shows",
            icon: Icons.tv,
            onTap: () => onPageSelected(2),
          ),
        ),
        TVFocusable(
          focusKey: "profile",
          upFocusKey: "tvshows",
          onFocused: () => onPageSelected(3),
          child: NavItem(
            title: "Profile",
            icon: Icons.list,
            onTap: () => onPageSelected(3),
          ),
        ),
      ],
    );
  }
}
