import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB));
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),
      // ignore: deprecated_member_use
      cardTheme: CardThemeData(elevation: 0, color: Colors.white.withOpacity(0.90), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26))),
      inputDecorationTheme: InputDecorationTheme(filled: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
    );
  }

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF8B5CF6), brightness: Brightness.dark);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF050816),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),
      // ignore: deprecated_member_use
      cardTheme: CardThemeData(elevation: 0, color: const Color(0xFF111827).withOpacity(0.90), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26))),
      inputDecorationTheme: InputDecorationTheme(filled: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
    );
  }
}
