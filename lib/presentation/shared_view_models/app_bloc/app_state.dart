import 'package:flutter/material.dart';

class AppState {
  final Color themeColor;
  final bool isDarkMode;

  AppState({required this.themeColor, required this.isDarkMode});

  AppState copyWith({Color? themeColor, bool? isDarkMode}) {
    return AppState(
      themeColor: themeColor ?? this.themeColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  String toString() {
    return 'AppState(themeColor: $themeColor, isDarkMode: $isDarkMode)';
  }
}

class AppInitialState extends AppState {
  // Defaults: deepOrange and light mode
  AppInitialState() : super(themeColor: Colors.deepOrange, isDarkMode: false);

  @override
  String toString() =>
      'AppInitialState(themeColor: $themeColor, isDarkMode: $isDarkMode)';
}
