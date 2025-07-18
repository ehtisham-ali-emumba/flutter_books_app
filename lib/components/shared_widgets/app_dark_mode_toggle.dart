import 'package:books/presentation/shared_view_models/app_bloc/app_bloc.dart';
import 'package:books/presentation/shared_view_models/app_bloc/app_event.dart';
import 'package:books/presentation/shared_view_models/app_bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDarkModeToggle extends StatelessWidget {
  const AppDarkModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final isDarkModeValue = state.isDarkMode;
        return IconButton(
          icon: Icon(isDarkModeValue ? Icons.dark_mode : Icons.light_mode),
          onPressed: () {
            context.read<AppBloc>().add(
              AppDarkModeToggled(isDarkMode: !isDarkModeValue),
            );
          },
        );
      },
    );
  }
}
