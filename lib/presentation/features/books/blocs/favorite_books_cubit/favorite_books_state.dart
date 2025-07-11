part of 'favorite_books_cubit.dart';

enum FavoriteBooksStatus { initial, loading, success, error }

class FavoriteBooksState extends Equatable {
  final List<Book> books;
  final FavoriteBooksStatus status;
  final String? errorMessage;

  const FavoriteBooksState({
    this.books = const [],
    this.status = FavoriteBooksStatus.initial,
    this.errorMessage,
  });

  FavoriteBooksState copyWith({
    List<Book>? books,
    FavoriteBooksStatus? status,
    String? errorMessage,
  }) {
    return FavoriteBooksState(
      books: books ?? this.books,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [books, status, errorMessage];
}
