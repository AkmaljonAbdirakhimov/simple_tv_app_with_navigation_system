import 'package:flutter/material.dart';

import 'app_layout.dart';
import 'focusable_item.dart';

class HorizontalList extends StatefulWidget {
  final double height;
  final double itemWidth;
  final int itemCount;
  final double separatorWidth;
  final Widget Function(BuildContext, int) itemBuilder;

  const HorizontalList({
    super.key,
    required this.height,
    required this.itemWidth,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorWidth = 16,
  });

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleFocusChange(int index) {
    if (_scrollController.hasClients) {
      final targetScrollOffset =
          index * (widget.itemWidth + widget.separatorWidth);
      _scrollController.animateTo(
        targetScrollOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewportWidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: widget.height,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
          right: viewportWidth - widget.itemWidth - widget.separatorWidth,
        ),
        separatorBuilder: (context, index) =>
            SizedBox(width: widget.separatorWidth),
        itemCount: widget.itemCount,
        itemBuilder: (context, index) {
          return FocusableItem(
            onFocus: (isFocused) {
              if (isFocused) {
                _handleFocusChange(index);
              }
            },
            onKeyEvent: (direction) {
              if (direction == TraversalDirection.left) {
                if (index == 0) {
                  NavigationItemFocusNodes.movies.requestFocus();
                }
              }
            },
            child: widget.itemBuilder(context, index),
          );
        },
      ),
    );
  }
}
