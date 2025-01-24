import 'package:flutter/material.dart';
import '../navigation/widgets/tv_focusable.dart';

class TVChannelsPage extends StatelessWidget {
  const TVChannelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live TV Channels',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          // Channel Categories
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TVFocusable(
                      focusKey: 'category_$i',
                      leftFocusKey: i > 0 ? 'category_${i - 1}' : null,
                      rightFocusKey: i < 4 ? 'category_${i + 1}' : null,
                      downFocusKey: 'channel_0',
                      autofocus: i == 0,
                      focusScale: 1.1,
                      focusColor: Colors.purple,
                      selectedColor: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'Category ${i + 1}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Channels Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 16 / 9,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return TVFocusable(
                  focusKey: 'channel_$index',
                  leftFocusKey: index % 4 > 0 ? 'channel_${index - 1}' : null,
                  rightFocusKey: index % 4 < 3 ? 'channel_${index + 1}' : null,
                  upFocusKey:
                      index >= 4 ? 'channel_${index - 4}' : 'category_0',
                  downFocusKey: index < 8 ? 'channel_${index + 4}' : null,
                  onSelect: () {
                    // Handle channel selection
                    print('Selected channel $index');
                  },
                  focusScale: 1.1,
                  focusColor: Colors.purple,
                  selectedColor: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://picsum.photos/seed/${index + 200}/400/225',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'LIVE',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Channel ${index + 1}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Now Playing: Show Title',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
