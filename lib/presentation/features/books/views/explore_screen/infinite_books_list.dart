import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/widgets/book_card.dart';
import 'package:flutter/material.dart';

class InfiniteBooksList extends StatelessWidget {
  final List<Book> books;
  final VoidCallback onLoadMore;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String heroPrefix;
  final String query;

  const InfiniteBooksList({
    super.key,
    required this.books,
    required this.onLoadMore,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.heroPrefix,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasSearched = query.trim().isNotEmpty;

    // 👇 Initial loader
    if (isLoading && books.isEmpty && hasSearched) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 👇 No results after search
    if (books.isEmpty && hasSearched && !isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('No books found.'),
        ),
      );
    }

    // 👇 No search done yet
    if (!hasSearched) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('Search for books to get started.'),
        ),
      );
    }

    // 👇 Display list with pagination spinner
    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - 300 &&
            !isLoadingMore &&
            hasMore) {
          onLoadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: books.length + (isLoadingMore && hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= books.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final book = books[index];
          return BookCard(book: book, heroId: '$heroPrefix${book.id}');
        },
      ),
    );
  }
}
