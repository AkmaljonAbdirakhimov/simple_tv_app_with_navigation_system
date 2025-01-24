import 'package:flutter/material.dart';
import 'focus_scale_wrapper.dart';

class TVItemWrapper extends StatelessWidget {
  final Widget child;
  final bool isFocused;
  final bool isSelected;
  final VoidCallback? onSelect;
  final double focusScale;
  final Duration duration;
  final Color focusColor;
  final Color? selectedColor;
  final double glowSpread;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const TVItemWrapper({
    super.key,
    required this.child,
    required this.isFocused,
    this.isSelected = false,
    this.onSelect,
    this.focusScale = 1.1,
    this.duration = const Duration(milliseconds: 200),
    this.focusColor = const Color(0xFF2196F3),
    this.selectedColor,
    this.glowSpread = 4.0,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: TVFocusWrapper(
        isFocused: isFocused,
        scale: focusScale,
        duration: duration,
        glowColor: isSelected ? (selectedColor ?? focusColor) : focusColor,
        glowSpread: isSelected ? glowSpread * 1.5 : glowSpread,
        borderRadius: borderRadius,
        padding: padding,
        child: child,
      ),
    );
  }
}

// Extension for common TV item styles
extension TVItemStyle on TVItemWrapper {
  static TVItemWrapper movie({
    required Widget child,
    required bool isFocused,
    bool isSelected = false,
    VoidCallback? onSelect,
    double focusScale = 1.1,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    EdgeInsetsGeometry padding = const EdgeInsets.all(8),
  }) {
    return TVItemWrapper(
      child: child,
      isFocused: isFocused,
      isSelected: isSelected,
      onSelect: onSelect,
      focusScale: focusScale,
      borderRadius: borderRadius,
      padding: padding,
      focusColor: const Color(0xFF2196F3),
      selectedColor: const Color(0xFFFF4081),
    );
  }

  static TVItemWrapper channel({
    required Widget child,
    required bool isFocused,
    bool isSelected = false,
    VoidCallback? onSelect,
    double focusScale = 1.05,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4)),
    EdgeInsetsGeometry padding = const EdgeInsets.all(4),
  }) {
    return TVItemWrapper(
      child: child,
      isFocused: isFocused,
      isSelected: isSelected,
      onSelect: onSelect,
      focusScale: focusScale,
      borderRadius: borderRadius,
      padding: padding,
      focusColor: const Color(0xFF4CAF50),
      selectedColor: const Color(0xFFFF9800),
    );
  }

  static TVItemWrapper banner({
    required Widget child,
    required bool isFocused,
    bool isSelected = false,
    VoidCallback? onSelect,
    double focusScale = 1.02,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
    EdgeInsetsGeometry padding = const EdgeInsets.all(12),
  }) {
    return TVItemWrapper(
      child: child,
      isFocused: isFocused,
      isSelected: isSelected,
      onSelect: onSelect,
      focusScale: focusScale,
      borderRadius: borderRadius,
      padding: padding,
      focusColor: const Color(0xFF9C27B0),
      selectedColor: const Color(0xFFE91E63),
      glowSpread: 8.0,
    );
  }
}
