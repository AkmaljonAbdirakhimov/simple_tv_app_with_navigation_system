import 'package:flutter/material.dart';
import '../widgets/app_layout.dart';
import '../widgets/focusable_item.dart';

class TVShowsScreen extends StatelessWidget {
  const TVShowsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('TV Shows'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade700,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Categories
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 16),
                  FocusableItem(
                    onPressed: () {},
                    onKeyEvent: (direction) {
                      if (direction == TraversalDirection.left) {
                        NavigationItemFocusNodes.tvShows.requestFocus();
                      } else if (direction == TraversalDirection.up) {
                        return KeyEventResult.handled;
                      }
                    },
                    child: const Chip(label: Text('All')),
                  ),
                  const SizedBox(width: 8),
                  FocusableItem(
                    onPressed: () {},
                    onKeyEvent: (direction) {
                      if (direction == TraversalDirection.up) {
                        return KeyEventResult.handled;
                      }
                    },
                    child: const Chip(label: Text('Action')),
                  ),
                  const SizedBox(width: 8),
                  FocusableItem(
                    onPressed: () {},
                    onKeyEvent: (direction) {
                      if (direction == TraversalDirection.up) {
                        return KeyEventResult.handled;
                      }
                    },
                    child: const Chip(label: Text('Comedy')),
                  ),
                  const SizedBox(width: 8),
                  FocusableItem(
                    onPressed: () {},
                    onKeyEvent: (direction) {
                      if (direction == TraversalDirection.up) {
                        return KeyEventResult.handled;
                      }
                    },
                    child: const Chip(label: Text('Drama')),
                  ),
                  const SizedBox(width: 8),
                  FocusableItem(
                    onPressed: () {},
                    onKeyEvent: (direction) {
                      if (direction == TraversalDirection.up) {
                        return KeyEventResult.handled;
                      }
                    },
                    child: const Chip(label: Text('Sci-Fi')),
                  ),
                ],
              ),
            ),
          ),

          // Grid of TV Shows
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 16 / 9,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FocusableItem(
                    onPressed: () {},
                    onKeyEvent: (direction) {
                      if (direction == TraversalDirection.left) {
                        if (index % 3 == 0) {
                          NavigationItemFocusNodes.tvShows.requestFocus();
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              color: Colors.grey[800],
                              child: Center(
                                child: Text('Show ${index + 1}'),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 8,
                            bottom: 8,
                            right: 8,
                            child: Text(
                              'TV Show ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
