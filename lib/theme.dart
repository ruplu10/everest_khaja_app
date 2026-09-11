import 'package:flutter/material.dart';

/// Colours match the Assessment 3 Figma prototype so the implemented
/// front end is visually consistent with the approved high-fidelity design.
class AppColors {
  static const brandRed = Color(0xFFB23A2E);
  static const gold = Color(0xFFC9891A);
  static const cream = Color(0xFFF5E9D8);
  static const textSecondary = Color(0xFF6B6B68);
  static const border = Color(0xFFE4E0D8);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brandRed,
      primary: AppColors.brandRed,
      secondary: AppColors.gold,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.brandRed,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brandRed,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
