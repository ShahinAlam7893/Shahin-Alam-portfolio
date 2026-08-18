import 'package:flutter/material.dart';

/// Accent colours used by the animated background, section eyebrows, borders
/// and highlights. Kept in one place so the palette stays consistent.
class AppColors {
  AppColors._();

  static const accentDark = Color(0xFF3FA9F5);
  static const accentLight = Color(0xFF2563EB);

  static Color accent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? accentDark : accentLight;

  /// Theme-aware translucent surface for cards (fixes the old
  /// `Colors.white.withOpacity(0.1)` cards that vanished in light mode).
  static Color surface(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return (isDark ? Colors.white : const Color(0xFF0A2540))
        .withOpacity(isDark ? 0.05 : 0.04);
  }

  static Color border(BuildContext context) => accent(context).withOpacity(0.25);
}
