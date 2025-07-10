import 'package:books/presentation/shared_blocs/app_bloc/app_event.dart';
import 'package:books/presentation/shared_blocs/app_bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState(themeColor: 'blue', isDarkMode: false)) {
    on<AppThemeColorChanged>(_onThemeChanged);
    on<AppDarkModeToggled>(_onDarkModeToggled);
  }

  void _onThemeChanged(AppThemeColorChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(themeColor: event.themeColor));
  }

  void _onDarkModeToggled(AppDarkModeToggled event, Emitter<AppState> emit) {
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }
}
