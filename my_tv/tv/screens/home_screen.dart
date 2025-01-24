import 'package:flutter/material.dart';
import '../widgets/app_layout.dart';
import '../widgets/focusable_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return FocusableItem(
            onPressed: () {},
            onKeyEvent: (direction) {
              if (index % 4 == 0) {
                if (direction == TraversalDirection.left) {
                  NavigationItemFocusNodes.home.requestFocus();
                }
              }
            },
            child: Container(
              color: Colors.grey[800],
              child: Center(
                child: Text('Item ${index + 1}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
