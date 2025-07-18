import 'package:books/components/shimers/carousel_shimmer.dart';
import 'package:books/core/di/locator.dart';
import 'package:books/data/repositories/book_repository.dart';
import 'package:books/presentation/features/books/view_models/book_list_state.dart';
import 'package:books/presentation/features/books/view_models/scifi_books_cubit.dart';
import 'package:books/presentation/features/books/widgets/books_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SciFiBooksCarousel extends StatelessWidget {
  const SciFiBooksCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return SciFiBooksCubit(getIt<BookRepository>())..loadSciFi();
      },
      child: BlocBuilder<SciFiBooksCubit, BookListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const CarouselShimmer();
          }
          return BooksCarousel(books: state.books, title: "SciFi");
        },
      ),
    );
  }
}
