// lib/di/service_locator.dart
import 'package:books/core/network/open_lib_api_client.dart';
import 'package:books/data/repositories/book_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<OpenLibApiClient>(OpenLibApiClient());
  getIt.registerSingleton<BookRepository>(
    BookRepository(getIt<OpenLibApiClient>()),
  );
}
