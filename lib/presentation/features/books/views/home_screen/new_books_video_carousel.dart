import 'package:books/components/shimers/carousel_shimmer.dart';
import 'package:books/core/di/locator.dart';
import 'package:books/data/repositories/book_repository.dart';
import 'package:books/presentation/features/books/view_models/bestseller_books_cubit.dart';
import 'package:books/presentation/features/books/view_models/book_list_state.dart';
import 'package:books/presentation/features/books/widgets/video_books_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewBooksCarousel extends StatelessWidget {
  const NewBooksCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return BestsellerBooksCubit(getIt<BookRepository>())..loadBestsellers();
      },
      child: BlocBuilder<BestsellerBooksCubit, BookListState>(
        builder: (context, state) {
          if (state.isLoading) return const CarouselShimmer();
          return VideoBooksCarousel(books: state.books, title: "New Arrival");
        },
      ),
    );
  }
}
