import 'package:flutter/material.dart';

class AppTheme {
  // Brand Color Palette
  static const Color primary = Color(0xFF4A3428); // Roasted Espresso
  static const Color primaryLight = Color(0xFF6F4E37); // Warm Coffee
  static const Color accent = Color(0xFFC88A58); // Warm Caramel Amber
  static const Color accentLight = Color(0xFFE8C8A3); // Soft Latte Cream
  static const Color background = Color(0xFFF9F7F4); // Clean Ivory Linen
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF2B211B); // Deep Dark Roast
  static const Color textSecondary = Color(0xFF756A63); // Muted Mocha
  static const Color successGreen = Color(0xFF2E7D32); // 24H Open Badge
  static const Color starGold = Color(0xFFFFA000); // Rating Star

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.black.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: primary,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
