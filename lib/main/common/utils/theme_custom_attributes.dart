import 'package:flutter/material.dart';

@immutable
class ThemeCustomAttributes extends ThemeExtension<ThemeCustomAttributes> {
  const ThemeCustomAttributes({
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  @override
  ThemeCustomAttributes copyWith(
      {Color? textColor, Color? backgroundColor, Color? borderColor}) {
    return ThemeCustomAttributes(
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  // Controls how the properties change on theme changes
  @override
  ThemeCustomAttributes lerp(
      ThemeExtension<ThemeCustomAttributes>? other, double t) {
    if (other is! ThemeCustomAttributes) {
      return this;
    }
    return ThemeCustomAttributes(
      textColor: Color.lerp(textColor, other.textColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
    );
  }

  // Controls how it displays when the instance is being passed
  // to the `print()` method.
  @override
  String toString() => 'ThemeCustomAttributes('
      'textColor: $textColor, backgroundColor: $backgroundColor, borderColor: $borderColor'
      ')';
  // the light theme
  static const light = ThemeCustomAttributes(
    textColor: Colors.black,
    backgroundColor: Colors.white,
    borderColor: Colors.black,
  );

  // the dark theme
  static const dark = ThemeCustomAttributes(
    textColor: Colors.white,
    backgroundColor: Colors.black87,
    borderColor: Colors.grey,
  );
}
