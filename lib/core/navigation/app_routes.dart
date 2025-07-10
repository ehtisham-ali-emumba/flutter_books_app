import 'package:books/components/layouts/app_drawer_layout.dart';
import 'package:books/components/layouts/app_tab_layout.dart';
import 'package:books/presentation/features/auth/views/social_signin_screen.dart';
import 'package:books/presentation/features/books/views/explore_screen/explore_screen.dart';
import 'package:books/presentation/features/books/views/home_screen/home_screen.dart';
import 'package:books/presentation/features/settings/views/settings_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/signin',
  routes: [
    GoRoute(path: '/signin', builder: (context, state) => SocialSignInScreen()),
    ShellRoute(
      builder: (context, state, child) {
        return AppDrawerLayout(child: child); // Custom Drawer Scaffold
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) => AppTabLayout(child: child),
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: HomeScreen()),
            ),
            GoRoute(
              path: '/explore',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: ExploreScreen()),
            ),
          ],
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => SettingsScreen(),
        ),
      ],
    ),
  ],
);
