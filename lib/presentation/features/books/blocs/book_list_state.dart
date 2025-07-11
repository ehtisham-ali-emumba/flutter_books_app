import 'package:books/data/models/book.dart';
import 'package:equatable/equatable.dart';

class BookListState extends Equatable {
  final bool isLoading;
  final List<Book> books;
  final String? error;

  const BookListState({
    this.isLoading = false,
    this.books = const [],
    this.error,
  });

  BookListState copyWith({bool? isLoading, List<Book>? books, String? error}) {
    return BookListState(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, books, error];
}
