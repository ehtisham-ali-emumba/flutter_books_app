import 'package:books/components/shimers/carousel_shimmer.dart';
import 'package:books/core/di/locator.dart';
import 'package:books/data/repositories/book_repository.dart';
import 'package:books/presentation/features/books/view_models/book_list_state.dart';
import 'package:books/presentation/features/books/view_models/history_books_cubit.dart';
import 'package:books/presentation/features/books/widgets/books_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryBooksCarousel extends StatelessWidget {
  const HistoryBooksCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return HistoryBooksCubit(getIt<BookRepository>())..loadHistory();
      },
      child: BlocBuilder<HistoryBooksCubit, BookListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const CarouselShimmer();
          }
          return BooksCarousel(books: state.books, title: "History");
        },
      ),
    );
  }
}
