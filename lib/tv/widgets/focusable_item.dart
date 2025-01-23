import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusableItem extends StatefulWidget {
  final Widget? child;
  final Function(TraversalDirection direction)? onKeyEvent;
  final VoidCallback? onPressed;
  final Function(bool isFocused)? onFocus;
  final FocusNode? focusNode;
  final bool autofocus;
  final BoxDecoration? decoration;
  final Widget Function(BuildContext context, bool isFocused)? builder;

  const FocusableItem({
    super.key,
    this.child,
    this.onKeyEvent,
    this.onPressed,
    this.onFocus,
    this.focusNode,
    this.autofocus = false,
    this.decoration,
    this.builder,
  });

  @override
  State<FocusableItem> createState() => _FocusableItemState();
}

class _FocusableItemState extends State<FocusableItem> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.select ||
          event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.gameButtonA) {
        widget.onPressed?.call();
        return KeyEventResult.handled;
      }

      if (widget.onKeyEvent != null) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
            event.logicalKey == LogicalKeyboardKey.arrowDown ||
            event.logicalKey == LogicalKeyboardKey.arrowLeft ||
            event.logicalKey == LogicalKeyboardKey.arrowRight) {
          final response = widget.onKeyEvent
              ?.call(event.logicalKey == LogicalKeyboardKey.arrowUp
                  ? TraversalDirection.up
                  : event.logicalKey == LogicalKeyboardKey.arrowDown
                      ? TraversalDirection.down
                      : event.logicalKey == LogicalKeyboardKey.arrowLeft
                          ? TraversalDirection.left
                          : TraversalDirection.right);

          if (response == KeyEventResult.handled) {
            return KeyEventResult.handled;
          }
        }
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      onKeyEvent: _handleKeyEvent,
      onFocusChange: widget.onFocus,
      child: Builder(builder: (context) {
        final isFocused = Focus.of(context).hasFocus;
        return GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: isFocused
                ? widget.decoration ??
                    BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    )
                : null,
            child: widget.builder?.call(context, isFocused) ?? widget.child,
          ),
        );
      }),
    );
  }
}
