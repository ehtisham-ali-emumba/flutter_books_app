part of 'review_books_cubit.dart';

enum BookReviewStatus { initial, loading, success, error }

class BookReviewState extends Equatable {
  final List<ReviewBook> reviews;
  final BookReviewStatus status;
  final String? errorMessage;

  const BookReviewState({
    this.reviews = const [],
    this.status = BookReviewStatus.initial,
    this.errorMessage,
  });

  BookReviewState copyWith({
    List<ReviewBook>? reviews,
    BookReviewStatus? status,
    String? errorMessage,
  }) {
    return BookReviewState(
      reviews: reviews ?? this.reviews,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [reviews, status, errorMessage];
}
