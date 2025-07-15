part of 'search_books_cubit.dart';

enum BookSearchStatus { initial, loading, success, loadingMore, error }

class BookSearchState extends Equatable {
  final List<Book> books;
  final BookSearchStatus status;
  final String query;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const BookSearchState({
    this.books = const [],
    this.status = BookSearchStatus.initial,
    this.query = '',
    this.page = 1,
    this.hasMore = true,
    this.errorMessage,
  });

  BookSearchState copyWith({
    List<Book>? books,
    BookSearchStatus? status,
    String? query,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) {
    return BookSearchState(
      books: books ?? this.books,
      status: status ?? this.status,
      query: query ?? this.query,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isInitialLoading =>
      status == BookSearchStatus.loading && books.isEmpty;
  bool get isLoadingMore =>
      status == BookSearchStatus.loadingMore && books.isNotEmpty;

  @override
  List<Object?> get props => [
    books,
    status,
    query,
    page,
    hasMore,
    errorMessage,
  ];
}
