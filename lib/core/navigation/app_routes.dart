import 'package:books/components/layouts/app_drawer/app_drawer_layout.dart';
import 'package:books/components/layouts/app_tab_layout.dart';
import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/auth/views/social_signin_screen.dart';
import 'package:books/presentation/features/books/views/add_edit_rate_book_screen.dart';
import 'package:books/presentation/features/books/views/book_details_screen/book_details_screen.dart';
import 'package:books/presentation/features/books/views/explore_screen/explore_screen.dart';
import 'package:books/presentation/features/books/views/favorite_books_screen/favorite_books_screen.dart';
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
        GoRoute(
          path: '/book/:bookId',
          builder: (context, state) {
            final Map<String, dynamic> extras =
                state.extra as Map<String, dynamic>;
            final book = extras['book'] as Book;
            final heroId = extras['heroId'] as String;
            return BookDetailsScreen(book: book, heroId: heroId);
          },
        ),
        GoRoute(
          path: "/favorite-books",
          builder: (context, state) => const FavoriteBooksScreen(),
        ),
        GoRoute(
          path: "/review-book/:bookId",
          builder: (context, state) {
            final bookId = state.pathParameters['bookId']!;
            final Map<String, dynamic> extras =
                state.extra as Map<String, dynamic>;
            final bookTitle = extras['bookTitle'] as String;
            return AddEditRateBookScreen(bookId: bookId, bookTitle: bookTitle);
          },
        ),
      ],
    ),
  ],
);
