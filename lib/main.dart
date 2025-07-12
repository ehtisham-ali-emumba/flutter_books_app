import 'package:books/core/constants/app_theme.dart';
import 'package:books/presentation/features/books/blocs/favorite_books_cubit/favorite_books_cubit.dart';
import 'package:books/presentation/shared_blocs/app_bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/locator.dart';
import 'core/navigation/app_routes.dart';
import 'presentation/shared_blocs/app_bloc/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppBloc()),
        BlocProvider(create: (_) => FavoriteBooksCubit()),
        // Add more BlocProviders here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final isDarkMode = state.isDarkMode;
        final Color themeColor = state.themeColor;

        return MaterialApp.router(
          routerConfig: appRouter,
          theme: AppTheme.getTheme(isDarkMode, themeColor),
        );
      },
    );
  }
}
