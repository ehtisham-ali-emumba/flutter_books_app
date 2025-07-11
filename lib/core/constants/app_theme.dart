import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData _lightTheme(Color primaryColor) {
    return ThemeData.light().copyWith(
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        surface: Colors.white,
      ),
    );
  }

  static ThemeData _darkTheme(Color primaryColor) {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      colorScheme: ColorScheme.dark(primary: primaryColor),
    );
  }

  static ThemeData getTheme(bool isDarkMode, Color primaryColor) {
    return isDarkMode ? _darkTheme(primaryColor) : _lightTheme(primaryColor);
  }
}
