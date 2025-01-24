import 'package:flutter/material.dart';
import 'nav_item.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onPageSelected;
  const Sidebar({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NavItem(
          title: "Home",
          icon: Icons.home,
          onTap: () => onPageSelected(0),
        ),
        NavItem(
          title: "Cinema",
          icon: Icons.movie,
          onTap: () => onPageSelected(1),
        ),
        NavItem(
          title: "TV Shows",
          icon: Icons.tv,
          onTap: () => onPageSelected(2),
        ),
        NavItem(
          title: "Profile",
          icon: Icons.list,
          onTap: () => onPageSelected(3),
        ),
      ],
    );
  }
}
