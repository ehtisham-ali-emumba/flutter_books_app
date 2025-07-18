import 'dart:io';

import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/components/shared_widgets/custom_snackbar.dart';
import 'package:books/core/constants/app_strings.dart';
import 'package:books/data/models/book.dart';
import 'package:books/data/models/review_book.dart';
import 'package:books/presentation/features/books/view_models/review_books_cubit/review_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookReviews extends StatelessWidget {
  final Book book;

  const BookReviews({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookReviewCubit, BookReviewState>(
      builder: (context, state) {
        final isLoading = state.status == BookReviewStatus.loading;
        final reviews = context.read<BookReviewCubit>().getReviewsForBook(
          book.id,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  AppStrings.reviews,
                  kind: TextKind.heading,
                  fontSize: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push(
                      "/review-book/${book.id}",
                      extra: {'bookTitle': book.title},
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(AppStrings.addReview),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (reviews.isEmpty)
              AppText(
                AppStrings.noReviews,
                kind: TextKind.body,
                color: Theme.of(context).colorScheme.onSurface,
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reviews
                    .map((review) => _buildReviewItem(review, context))
                    .toList(),
              ),
          ],
        );
      },
    );
  }

  Widget _buildReviewItem(ReviewBook review, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade800.withOpacity(0.5)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username + stars + delete icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                review.userName,
                kind: TextKind.heading,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (index) => Icon(
                      index < review.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      _showDeleteReviewDialog(context, review);
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Image
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(File(review.imageFilePath), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),

          // Review comment
          AppText(review.comment, kind: TextKind.body),
          const SizedBox(height: 4),

          // Date
          AppText(
            '${review.datePosted.day}/${review.datePosted.month}/${review.datePosted.year}',
            kind: TextKind.caption,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  void _showDeleteReviewDialog(BuildContext context, ReviewBook review) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.deleteReview),
        content: const Text(AppStrings.areYouSureToDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<BookReviewCubit>().deleteReview(
                review.bookId,
                review.id,
              );
              Navigator.pop(ctx);
              CustomSnackbar.show(context, AppStrings.reviewDeleted);
            },
            child: const Text(
              AppStrings.delete,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
