import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A wrapper widget that makes any existing widget TV-navigation friendly.
///
/// Example usage:
/// ```dart
/// TVFocusable(
///   focusKey: 'my_button',
///   onFocused: () => print('Button focused'),
///   onBlurred: () => print('Button lost focus'),
///   onSelect: () => print('Button selected'),
///   leftFocusKey: 'left_button',
///   rightFocusKey: 'right_button',
///   upFocusKey: 'up_button',
///   downFocusKey: 'down_button',
///   child: ElevatedButton(
///     onPressed: () {},
///     child: Text('Click me'),
///   ),
/// )
/// ```
class TVFocusable extends StatefulWidget {
  /// Unique key for this focusable widget
  final String focusKey;

  /// The widget to make focusable
  final Widget child;

  /// Optional group identifier to maintain focus state within groups
  final String? focusGroup;

  /// Focus keys for navigation
  final String? leftFocusKey;
  final String? rightFocusKey;
  final String? upFocusKey;
  final String? downFocusKey;

  /// Callbacks
  final VoidCallback? onFocused;
  final VoidCallback? onBlurred;
  final VoidCallback? onSelect;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;
  final VoidCallback? onUp;
  final VoidCallback? onDown;

  /// Visual properties
  final double focusScale;
  final Duration animationDuration;
  final BorderRadius? borderRadius;
  final Color? focusColor;
  final Color? selectedColor;
  final EdgeInsets? focusPadding;
  final EdgeInsets? margin;

  /// Focus behavior
  final bool autofocus;
  final bool enabled;
  final bool canRequestFocus;

  /// Scroll settings
  final bool scrollToWidget;

  const TVFocusable({
    super.key,
    required this.focusKey,
    required this.child,
    this.focusGroup,
    this.leftFocusKey,
    this.rightFocusKey,
    this.upFocusKey,
    this.downFocusKey,
    this.onFocused,
    this.onBlurred,
    this.onSelect,
    this.onLeft,
    this.onRight,
    this.onUp,
    this.onDown,
    this.focusScale = 1,
    this.animationDuration = const Duration(milliseconds: 200),
    this.borderRadius,
    this.focusColor,
    this.selectedColor,
    this.focusPadding,
    this.margin,
    this.autofocus = false,
    this.enabled = true,
    this.canRequestFocus = true,
    this.scrollToWidget = true,
  });

  @override
  State<TVFocusable> createState() => _TVFocusableState();
}

class _TVFocusableState extends State<TVFocusable> {
  bool _isFocused = false;
  bool _isSelected = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(
      debugLabel: widget.focusKey,
      canRequestFocus: widget.canRequestFocus && widget.enabled,
    );
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _TVFocusManager().register(widget.focusKey, this);

    if (widget.autofocus && widget.enabled) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _TVFocusManager().unregister(widget.focusKey);
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!mounted) return;
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_isFocused) {
      _TVFocusManager().updateLastFocused(widget.focusKey);
      widget.onFocused?.call();
      if (widget.scrollToWidget) {
        _ensureVisible();
      }
    } else {
      widget.onBlurred?.call();
    }
  }

  void _handleKeyEvent(KeyEvent event) {
    if (!widget.enabled || event is! KeyDownEvent) return;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.select:
      case LogicalKeyboardKey.enter:
        setState(() => _isSelected = true);
        widget.onSelect?.call();
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) setState(() => _isSelected = false);
        });
        break;

      case LogicalKeyboardKey.arrowLeft:
        if (widget.leftFocusKey != null) {
          final targetState =
              _TVFocusManager().findFocusable(widget.leftFocusKey!);
          if (targetState != null &&
              targetState.mounted &&
              targetState.widget.enabled) {
            targetState._focusNode.requestFocus();
            widget.onLeft?.call();
          }
        }
        break;

      case LogicalKeyboardKey.arrowRight:
        if (widget.rightFocusKey != null) {
          final targetState =
              _TVFocusManager().findFocusable(widget.rightFocusKey!);
          if (targetState != null &&
              targetState.mounted &&
              targetState.widget.enabled) {
            targetState._focusNode.requestFocus();
            widget.onRight?.call();
          }
        }
        break;

      case LogicalKeyboardKey.arrowUp:
        if (widget.upFocusKey != null) {
          final targetState =
              _TVFocusManager().findFocusable(widget.upFocusKey!);
          if (targetState != null &&
              targetState.mounted &&
              targetState.widget.enabled) {
            targetState._focusNode.requestFocus();
            widget.onUp?.call();
          }
        }
        break;

      case LogicalKeyboardKey.arrowDown:
        if (widget.downFocusKey != null) {
          final targetState =
              _TVFocusManager().findFocusable(widget.downFocusKey!);
          if (targetState != null &&
              targetState.mounted &&
              targetState.widget.enabled) {
            targetState._focusNode.requestFocus();
            widget.onDown?.call();
          }
        }
        break;
    }
  }

  void _ensureVisible() {
    // Use Scrollable.ensureVisible to bring the widget into view
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      alignment: 0.5, // Center the widget in the scroll view
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Focus(
      focusNode: _focusNode,
      onKeyEvent: (_, event) {
        _handleKeyEvent(event);
        return KeyEventResult.handled;
      },
      child: AnimatedContainer(
        duration: widget.animationDuration,
        transform: Matrix4.identity()
          ..scale(_isFocused ? widget.focusScale : 1.0),
        padding: _isFocused ? widget.focusPadding : null,
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: _isFocused
              ? Border.all(
                  color: _isSelected
                      ? (widget.selectedColor ?? Colors.orange)
                      : (widget.focusColor ?? Colors.blue),
                  width: 2,
                )
              : null,
        ),
        child: widget.child,
      ),
    );

    // Wrap with opacity if disabled
    if (!widget.enabled) {
      child = Opacity(
        opacity: 0.5,
        child: child,
      );
    }

    return child;
  }
}

/// Focus manager to handle dynamic widgets
class _TVFocusManager {
  static final _TVFocusManager _instance = _TVFocusManager._internal();
  factory _TVFocusManager() => _instance;
  _TVFocusManager._internal();

  final Map<String, _TVFocusableState> _focusables = {};
  final Queue<String> _focusQueue = Queue<String>();
  final Map<String, String> _lastFocusedByGroup = {};
  String? _lastFocusedKey;

  void register(String key, _TVFocusableState state) {
    _focusables[key] = state;
    if (state.widget.focusGroup != null &&
        !_lastFocusedByGroup.containsKey(state.widget.focusGroup)) {
      _lastFocusedByGroup[state.widget.focusGroup!] = key;
    }
  }

  void unregister(String key) {
    final state = _focusables[key];
    _focusables.remove(key);
    _focusQueue.remove(key);

    if (state?.widget.focusGroup != null) {
      if (_lastFocusedByGroup[state!.widget.focusGroup] == key) {
        _lastFocusedByGroup.remove(state.widget.focusGroup);
      }
    }

    if (_lastFocusedKey == key) {
      _restoreFocus();
    }
  }

  void _restoreFocus() {
    // Try to focus the next available widget
    while (_focusQueue.isNotEmpty) {
      String nextKey = _focusQueue.last;
      if (_focusables.containsKey(nextKey)) {
        _focusables[nextKey]?._focusNode.requestFocus();
        _lastFocusedKey = nextKey;
        return;
      }
      _focusQueue.removeLast();
    }

    // If queue is empty, try to focus the nearest available widget
    if (_focusables.isNotEmpty) {
      String firstKey = _focusables.keys.first;
      _focusables[firstKey]?._focusNode.requestFocus();
      _lastFocusedKey = firstKey;
    }
  }

  void addToFocusQueue(String key) {
    if (!_focusQueue.contains(key)) {
      _focusQueue.addLast(key);
    }
  }

  void updateLastFocused(String key) {
    _lastFocusedKey = key;
    addToFocusQueue(key);

    final state = _focusables[key];
    if (state?.widget.focusGroup != null) {
      _lastFocusedByGroup[state!.widget.focusGroup!] = key;
    }
  }

  String? getLastFocusedInGroup(String group) {
    return _lastFocusedByGroup[group];
  }

  _TVFocusableState? findFocusable(String key) {
    // If the key contains a group identifier (e.g., "group:default")
    if (key.startsWith("group:")) {
      final group = key.substring(6);
      final lastFocused = _lastFocusedByGroup[group];
      return lastFocused != null ? _focusables[lastFocused] : null;
    }
    return _focusables[key];
  }
}

/// Root widget that enables TV navigation
class TVFocusableApp extends StatelessWidget {
  final Widget child;

  const TVFocusableApp({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
