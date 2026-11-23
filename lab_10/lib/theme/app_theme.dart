import 'package:flutter/material.dart';

class AppSpacing {
  static const s = 8.0, m = 12.0, l = 20.0;
}

class AppTheme {
  static const _seed = Color(0xFF0F8B7D); // TODO: primary colour from Figma
  static const _radius = 16.0;            // TODO: corner radius from Figma
  static const _font = null as String?;   // TODO: font family from Figma, e.g. 'Inter'

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(seedColor: _seed);
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius));
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: _font,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(centerTitle: false),
      cardTheme: CardThemeData(elevation: 0, color: scheme.surfaceContainerHighest, shape: shape),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52), shape: shape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52), shape: shape),
      ),
      chipTheme: ChipThemeData(shape: shape),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: scheme.primaryContainer,
      ),
    );
  }
}
