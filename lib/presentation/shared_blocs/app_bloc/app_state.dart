class AppState {
  final String themeColor;
  final bool isDarkMode;

  AppState({required this.themeColor, required this.isDarkMode});

  AppState copyWith({String? themeColor, bool? isDarkMode}) {
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
