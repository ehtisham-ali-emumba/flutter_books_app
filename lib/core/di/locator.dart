// lib/di/service_locator.dart
import 'package:books/core/network/open_lib_api_client.dart';
import 'package:books/core/services/shared_prefs_service.dart';
import 'package:books/data/repositories/book_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPrefsService = SharedPrefsService();
  await sharedPrefsService.init(); // instance init, not static

  getIt.registerSingleton<SharedPrefsService>(sharedPrefsService);
  getIt.registerSingleton<OpenLibApiClient>(OpenLibApiClient());
  getIt.registerSingleton<BookRepository>(
    BookRepository(getIt<OpenLibApiClient>()),
  );
}
