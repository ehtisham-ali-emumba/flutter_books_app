import 'package:books/core/constants/storage_keys.dart';
import 'package:books/core/di/locator.dart';
import 'package:books/core/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final SharedPrefsService _prefs = getIt<SharedPrefsService>();

  AppBloc() : super(AppInitialState()) {
    on<AppThemeColorChanged>(_onThemeChanged);
    on<AppDarkModeToggled>(_onDarkModeToggled);
    _loadThemeFromPrefs();
  }

  void _loadThemeFromPrefs() {
    // Load color and dark mode from shared prefs
    final int? colorValue = _prefs.getInt(StorageKeys.themeColor);
    final bool? isDark = _prefs.getBool(StorageKeys.isDarkMode);

    if (colorValue != null || isDark != null) {
      emit(
        state.copyWith(
          themeColor: colorValue != null ? Color(colorValue) : state.themeColor,
          isDarkMode: isDark ?? state.isDarkMode,
        ),
      );
    }
  }

  void _onThemeChanged(AppThemeColorChanged event, Emitter<AppState> emit) {
    _prefs.setInt(StorageKeys.themeColor, event.themeColor.value);
    emit(state.copyWith(themeColor: event.themeColor));
  }

  void _onDarkModeToggled(AppDarkModeToggled event, Emitter<AppState> emit) {
    _prefs.setBool(StorageKeys.isDarkMode, event.isDarkMode);
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }
}
