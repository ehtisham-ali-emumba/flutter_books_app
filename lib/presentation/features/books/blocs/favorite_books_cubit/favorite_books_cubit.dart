import 'package:books/data/models/book.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_books_state.dart';

class FavoriteBooksCubit extends Cubit<FavoriteBooksState> {
  FavoriteBooksCubit() : super(const FavoriteBooksState()) {
    loadFavoriteBooks();
  }

  void loadFavoriteBooks() {
    emit(state.copyWith(status: FavoriteBooksStatus.loading));
    try {
      // For now, just initialize with empty list
      emit(
        state.copyWith(books: const [], status: FavoriteBooksStatus.success),
      );
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
      final List<Book> currentBooks = List.from(state.books);
      final int existingIndex = currentBooks.indexWhere(
        (item) => item.id == book.id,
      );

      if (existingIndex >= 0) {
        currentBooks.removeAt(existingIndex);
      } else {
        currentBooks.add(book);
      }
      emit(
        state.copyWith(
          books: currentBooks,
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
