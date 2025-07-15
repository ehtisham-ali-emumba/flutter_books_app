import 'package:books/core/utils/image_utils.dart';
import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/blocs/favorite_books_cubit/favorite_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_review.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;
  final String heroId;

  const BookDetailsScreen({
    super.key,
    required this.book,
    required this.heroId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        elevation: 0,
        actions: [
          BlocBuilder<FavoriteBooksCubit, FavoriteBooksState>(
            builder: (blocContext, state) {
              final bool isFavorite = blocContext
                  .read<FavoriteBooksCubit>()
                  .isFavorite(book.id);

              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  blocContext.read<FavoriteBooksCubit>().toggleFavorite(book);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: heroId,
                child: Image.network(
                  ImageUtils.getBookCoverImagePath(book.coverImageUrlId),
                  height: 300,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.book, size: 120),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              book.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'By ${book.author}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, 'Published', book.publishYear.toString()),
            const SizedBox(height: 8),
            _buildInfoRow(context, 'ID', book.id),
            BookReviews(book: book),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
