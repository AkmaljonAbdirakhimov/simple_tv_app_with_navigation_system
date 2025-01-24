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

  const TVFocusable({
    super.key,
    required this.focusKey,
    required this.child,
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
    this.focusScale = 1.05,
    this.animationDuration = const Duration(milliseconds: 200),
    this.borderRadius,
    this.focusColor,
    this.selectedColor,
    this.focusPadding,
    this.margin,
    this.autofocus = false,
    this.enabled = true,
    this.canRequestFocus = true,
  });

  @override
  State<TVFocusable> createState() => _TVFocusableState();
}

class _TVFocusableState extends State<TVFocusable> {
  bool _isFocused = false;
  bool _isSelected = false;
  late final FocusNode _focusNode;
  _TVFocusableScope? _scope;

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
    _scope = context.findAncestorWidgetOfExactType<_TVFocusableScope>();
    _scope?.register(widget.focusKey, this);

    if (widget.autofocus && widget.enabled) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _scope?.unregister(widget.focusKey);
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
      widget.onFocused?.call();
    } else {
      widget.onBlurred?.call();
    }
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (!widget.enabled || event is! RawKeyDownEvent) return;

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
          final targetState = _scope?.focusables[widget.leftFocusKey!];
          if (targetState != null) {
            targetState._focusNode.requestFocus();
            widget.onLeft?.call();
          }
        }
        break;

      case LogicalKeyboardKey.arrowRight:
        if (widget.rightFocusKey != null) {
          final targetState = _scope?.focusables[widget.rightFocusKey!];
          if (targetState != null) {
            targetState._focusNode.requestFocus();
            widget.onRight?.call();
          }
        }
        break;

      case LogicalKeyboardKey.arrowUp:
        if (widget.upFocusKey != null) {
          final targetState = _scope?.focusables[widget.upFocusKey!];
          if (targetState != null) {
            targetState._focusNode.requestFocus();
            widget.onUp?.call();
          }
        }
        break;

      case LogicalKeyboardKey.arrowDown:
        if (widget.downFocusKey != null) {
          final targetState = _scope?.focusables[widget.downFocusKey!];
          if (targetState != null) {
            targetState._focusNode.requestFocus();
            widget.onDown?.call();
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Focus(
      focusNode: _focusNode,
      onKey: (_, event) {
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

/// Scope widget to manage TVFocusable widgets
class _TVFocusableScope extends InheritedWidget {
  final Map<String, _TVFocusableState> focusables = {};

  _TVFocusableScope({
    super.key,
    required super.child,
  });

  void register(String key, _TVFocusableState state) {
    focusables[key] = state;
  }

  void unregister(String key) {
    focusables.remove(key);
  }

  @override
  bool updateShouldNotify(_TVFocusableScope oldWidget) => false;
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
    return _TVFocusableScope(
      child: child,
    );
  }
}
  