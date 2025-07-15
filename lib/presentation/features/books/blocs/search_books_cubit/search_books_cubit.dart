// cubit/book_search_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:books/data/models/book.dart';
import 'package:books/data/repositories/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_books_state.dart';

class BookSearchCubit extends Cubit<BookSearchState> {
  final BookRepository repository;

  BookSearchCubit(this.repository) : super(const BookSearchState());

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(const BookSearchState()); // Reset
      return;
    }

    emit(
      state.copyWith(
        status: BookSearchStatus.loading,
        query: query,
        page: 1,
        books: [],
      ),
    );

    try {
      final books = await repository.searchBooks(query, offset: 0);
      emit(
        state.copyWith(
          status: BookSearchStatus.success,
          books: books,
          hasMore: books.length == 20,
          page: 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookSearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.status == BookSearchStatus.loadingMore ||
        !state.hasMore ||
        state.query.trim().isEmpty)
      return;

    final nextPage = state.page + 1;
    final offset = (nextPage - 1) * 20;

    emit(state.copyWith(status: BookSearchStatus.loadingMore));

    try {
      final books = await repository.searchBooks(state.query, offset: offset);
      emit(
        state.copyWith(
          status: BookSearchStatus.success,
          books: [...state.books, ...books],
          hasMore: books.length == 20,
          page: nextPage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookSearchStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
