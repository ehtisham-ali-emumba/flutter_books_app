import 'dart:convert';

import 'package:books/core/constants/storage_keys.dart';
import 'package:books/core/di/locator.dart';
import 'package:books/core/services/shared_prefs_service.dart';
import 'package:books/data/models/review_book.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'review_books_state.dart';

class BookReviewCubit extends Cubit<BookReviewState> {
  final SharedPrefsService _prefs = getIt<SharedPrefsService>();

  BookReviewCubit() : super(const BookReviewState()) {
    loadReviews();
  }

  void loadReviews() {
    emit(state.copyWith(status: BookReviewStatus.loading));
    try {
      final reviews = _prefs.getObjectList<ReviewBook>(
        StorageKeys.reviewBooks,
        (jsonString) => ReviewBook.fromJson(json.decode(jsonString)),
      );
      emit(state.copyWith(reviews: reviews, status: BookReviewStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: BookReviewStatus.error,
          errorMessage: 'Failed to load reviews: ${e.toString()}',
        ),
      );
    }
  }

  void addReview({
    required String bookId,
    required String userName,
    required String comment,
    required double rating,
    required String imageFilePath,
  }) {
    try {
      final newReview = ReviewBook(
        id: const Uuid().v4(),
        bookId: bookId,
        userName: userName,
        comment: comment,
        rating: rating,
        datePosted: DateTime.now(),
        imageFilePath: imageFilePath,
      );

      final updatedReviews = List<ReviewBook>.from(state.reviews)
        ..add(newReview);

      _prefs.setObjectList<ReviewBook>(
        StorageKeys.reviewBooks,
        updatedReviews,
        (review) => json.encode(review.toJson()),
      );

      emit(
        state.copyWith(
          reviews: updatedReviews,
          status: BookReviewStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookReviewStatus.error,
          errorMessage: 'Failed to add review: ${e.toString()}',
        ),
      );
    }
  }

  List<ReviewBook> getReviewsForBook(String bookId) {
    return state.reviews.where((r) => r.bookId == bookId).toList();
  }

  void clearReviews() {
    try {
      _prefs.setObjectList<ReviewBook>(
        StorageKeys.reviewBooks,
        [],
        (review) => json.encode(review.toJson()),
      );
      emit(state.copyWith(reviews: const [], status: BookReviewStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: BookReviewStatus.error,
          errorMessage: 'Failed to clear reviews: ${e.toString()}',
        ),
      );
    }
  }

  void deleteReview(String bookId, String reviewId) {
    try {
      final updatedReviews = state.reviews.where((review) {
        return !(review.bookId == bookId && review.id == reviewId);
      }).toList();

      _prefs.setObjectList<ReviewBook>(
        StorageKeys.reviewBooks,
        updatedReviews,
        (review) => json.encode(review.toJson()),
      );

      emit(
        state.copyWith(
          reviews: updatedReviews,
          status: BookReviewStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookReviewStatus.error,
          errorMessage: 'Failed to delete review: ${e.toString()}',
        ),
      );
    }
  }
}
