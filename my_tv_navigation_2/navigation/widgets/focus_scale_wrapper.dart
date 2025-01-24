import 'package:flutter/material.dart';

class TVFocusWrapper extends StatefulWidget {
  final Widget child;
  final bool isFocused;
  final double scale;
  final Duration duration;
  final Color glowColor;
  final double glowSpread;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const TVFocusWrapper({
    super.key,
    required this.child,
    required this.isFocused,
    this.scale = 1.1,
    this.duration = const Duration(milliseconds: 200),
    this.glowColor = const Color(0xFF2196F3),
    this.glowSpread = 4.0,
    this.borderRadius,
    this.padding,
  });

  @override
  State<TVFocusWrapper> createState() => _TVFocusWrapperState();
}

class _TVFocusWrapperState extends State<TVFocusWrapper> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: widget.isFocused
            ? [
                BoxShadow(
                  color: widget.glowColor.withOpacity(0.6),
                  blurRadius: widget.glowSpread * 2,
                  spreadRadius: widget.glowSpread,
                ),
              ]
            : null,
      ),
      child: AnimatedScale(
        scale: widget.isFocused ? widget.scale : 1.0,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
