import 'dart:convert';

import 'package:books/core/constants/storage_keys.dart';
import 'package:books/core/di/locator.dart';
import 'package:books/core/services/shared_prefs_service.dart';
import 'package:books/data/models/book.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_books_state.dart';

class FavoriteBooksCubit extends Cubit<FavoriteBooksState> {
  final SharedPrefsService _prefs = getIt<SharedPrefsService>();

  FavoriteBooksCubit() : super(const FavoriteBooksState()) {
    loadFavoriteBooks();
  }

  void loadFavoriteBooks() {
    emit(state.copyWith(status: FavoriteBooksStatus.loading));
    try {
      final books = getIt<SharedPrefsService>().getObjectList<Book>(
        StorageKeys.favoriteBooks,
        (jsonString) => Book.fromJson(json.decode(jsonString)),
      );

      emit(state.copyWith(books: books, status: FavoriteBooksStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteBooksStatus.error,
          errorMessage: 'Failed to load favorite books: ${e.toString()}',
        ),
      );
    }
  }

  void toggleFavorite(Book book) {
    try {
      final List<Book> updatedBooks = List.from(state.books);
      final existingIndex = updatedBooks.indexWhere((b) => b.id == book.id);

      if (existingIndex >= 0) {
        updatedBooks.removeAt(existingIndex);
      } else {
        updatedBooks.add(book);
      }

      _prefs.setObjectList<Book>(
        StorageKeys.favoriteBooks,
        updatedBooks,
        (book) => json.encode(book.toJson()),
      );

      emit(
        state.copyWith(
          books: updatedBooks,
          status: FavoriteBooksStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteBooksStatus.error,
          errorMessage: 'Failed to toggle favorite: ${e.toString()}',
        ),
      );
    }
  }

  bool isFavorite(String bookId) {
    return state.books.any((book) => book.id == bookId);
  }

  void clearFavorites() {
    try {
      _prefs.setObjectList<Book>(
        StorageKeys.favoriteBooks,
        [],
        (book) => json.encode(book.toJson()),
      );

      emit(
        state.copyWith(books: const [], status: FavoriteBooksStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteBooksStatus.error,
          errorMessage: 'Failed to clear favorites: ${e.toString()}',
        ),
      );
    }
  }
}
