import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/widgets/book_card.dart';
import 'package:flutter/material.dart';

class InfiniteBooksList extends StatelessWidget {
  final List<Book> books;
  final VoidCallback onLoadMore;
  final bool isLoading;
  final bool hasMore;
  final String heroPrefix;
  final String query; // We use this to check if a search was performed

  const InfiniteBooksList({
    super.key,
    required this.books,
    required this.onLoadMore,
    required this.isLoading,
    required this.hasMore,
    required this.heroPrefix,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasSearched = query.trim().isNotEmpty;

    if (isLoading && books.isEmpty && hasSearched) {
      // 👇 Initial search loader (only if user has typed something)
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (books.isEmpty && hasSearched && !isLoading) {
      // 👇 No results after search
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('No books found.'),
        ),
      );
    }

    if (!hasSearched) {
      // 👇 No search done yet
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('Search for books to get started.'),
        ),
      );
    }

    // 👇 Display list with optional bottom loader
    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - 300 &&
            !isLoading &&
            hasMore) {
          onLoadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: books.length + (isLoading && hasMore ? 1 : 0),
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
