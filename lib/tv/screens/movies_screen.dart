import 'package:flutter/material.dart';
import '../widgets/movie_banner.dart';
import '../widgets/focusable_item.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FocusTraversalGroup(
        policy: ReadingOrderTraversalPolicy(),
        child: ListView(
          children: [
            // Featured Movie Banner
            const MovieBanner(
              title: 'Avatar: The Way of Water',
              description: 'Return to Pandora in this epic adventure...',
              imageUrl: 'https://example.com/avatar.jpg',
            ),
            const SizedBox(height: 24),

            ...List.generate(
              3,
              (index) => FocusScope(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FocusableItem(
                      autofocus: index == 0,
                      onPressed: () {},
                      onKeyEvent: (direction) {
                        if (direction == TraversalDirection.up) {
                          FocusScope.of(context).previousFocus();
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Trending Now'),
                          Text('See All'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          FocusableItem(
                            onPressed: () {},
                            onKeyEvent: (direction) {
                              if (direction == TraversalDirection.down) {
                                FocusScope.of(context).nextFocus();
                                return KeyEventResult.handled;
                              }
                              return KeyEventResult.ignored;
                            },
                            child: Container(
                              width: 140,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          FocusableItem(
                            onPressed: () {},
                            onKeyEvent: (direction) {
                              if (direction == TraversalDirection.down) {
                                FocusScope.of(context).nextFocus();
                                return KeyEventResult.handled;
                              }
                              return KeyEventResult.ignored;
                            },
                            child: Container(
                              width: 140,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
