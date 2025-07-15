import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/widgets/book_card.dart';
import 'package:flutter/material.dart';

class InfiniteBooksList extends StatelessWidget {
  final List<Book> books;
  final VoidCallback onLoadMore;
  final bool isLoading;
  final bool hasMore;
  final String heroPrefix;

  const InfiniteBooksList({
    super.key,
    required this.books,
    required this.onLoadMore,
    required this.isLoading,
    required this.hasMore,
    required this.heroPrefix,
  });

  @override
  Widget build(BuildContext context) {
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
        itemCount: books.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= books.length) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          final book = books[index];
          return BookCard(book: book, heroId: '$heroPrefix${book.id}');
        },
      ),
    );
  }
}
