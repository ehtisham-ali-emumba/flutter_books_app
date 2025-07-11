import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/blocs/favorite_books_cubit/favorite_books_cubit.dart';
import 'package:books/presentation/features/books/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBooksScreen extends StatelessWidget {
  const FavoriteBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<FavoriteBooksCubit, FavoriteBooksState>(
        builder: (blocContext, state) {
          switch (state.status) {
            case FavoriteBooksStatus.initial:
            case FavoriteBooksStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case FavoriteBooksStatus.success:
              if (state.books.isEmpty) {
                return const Center(
                  child: AppText('You have no favorite books yet'),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.books.length,
                itemBuilder: (_, index) {
                  final Book book = state.books[index];
                  return BookCard(book: book, heroId: "favorite-${book.id}");
                },
              );
            case FavoriteBooksStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    AppText(
                      state.errorMessage ?? 'An error occurred',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        blocContext
                            .read<FavoriteBooksCubit>()
                            .loadFavoriteBooks();
                      },
                      child: const AppText('Retry'),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
