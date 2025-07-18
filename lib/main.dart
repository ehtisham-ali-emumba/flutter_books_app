import 'package:books/core/constants/app_theme.dart';
import 'package:books/presentation/features/books/view_models/favorite_books_cubit/favorite_books_cubit.dart';
import 'package:books/presentation/shared_view_models/app_bloc/app_bloc.dart';
import 'package:books/presentation/shared_view_models/app_bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/locator.dart';
import 'core/navigation/app_routes.dart';
import 'presentation/features/books/view_models/review_books_cubit/review_books_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AppBloc()),
            BlocProvider(create: (_) => FavoriteBooksCubit()),
            BlocProvider(create: (_) => BookReviewCubit()),
            // Add more BlocProviders here if needed
          ],
          child: const MyApp(),
        );
      },
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
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
