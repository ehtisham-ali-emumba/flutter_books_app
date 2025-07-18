import 'dart:ui';

class AppEvent {
  const AppEvent();
}

class AppThemeColorChanged extends AppEvent {
  final Color themeColor;

  const AppThemeColorChanged(this.themeColor);

  @override
  String toString() => 'AppThemeColorChanged(themeColor: $themeColor)';
}

class AppDarkModeToggled extends AppEvent {
  final bool isDarkMode;

  const AppDarkModeToggled({required this.isDarkMode});

  @override
  String toString() => 'AppDarkModeToggled(isDarkMode: $isDarkMode)';
}
