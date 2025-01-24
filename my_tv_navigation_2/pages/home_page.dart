import 'package:flutter/material.dart';
import '../navigation/widgets/tv_focusable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          // Featured Content
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 16 / 9,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return TVFocusable(
                  focusKey: 'featured_$index',
                  leftFocusKey: index % 4 > 0 ? 'featured_${index - 1}' : null,
                  rightFocusKey: index % 4 < 3 ? 'featured_${index + 1}' : null,
                  upFocusKey: index >= 4 ? 'featured_${index - 4}' : null,
                  downFocusKey: index < 4 ? 'featured_${index + 4}' : null,
                  onSelect: () {
                    // Handle selection
                    print('Selected featured item $index');
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
                          'https://picsum.photos/seed/$index/400/225',
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
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Featured Item ${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
