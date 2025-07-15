import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/components/shared_widgets/dnd_reorderable_grid.dart';
import 'package:books/core/constants/app_strings.dart';
import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/blocs/favorite_books_cubit/favorite_books_cubit.dart';
import 'package:books/presentation/features/books/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBooksScreen extends StatefulWidget {
  const FavoriteBooksScreen({super.key});

  @override
  State<FavoriteBooksScreen> createState() => _FavoriteBooksScreenState();
}

class _FavoriteBooksScreenState extends State<FavoriteBooksScreen> {
  List<Book> _books = [];

  void _handleState(FavoriteBooksState state) {
    if (state.status == FavoriteBooksStatus.success) {
      setState(() {
        _books = List<Book>.from(state.books);
      });
    } else if (state.status == FavoriteBooksStatus.initial) {
      context.read<FavoriteBooksCubit>().loadFavoriteBooks();
    }
  }

  @override
  void initState() {
    super.initState();

    // Run this after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleState(context.read<FavoriteBooksCubit>().state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.favoriteBooks),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<FavoriteBooksCubit, FavoriteBooksState>(
        listener: (context, state) {
          _handleState(state);
        },
        builder: (blocContext, state) {
          switch (state.status) {
            case FavoriteBooksStatus.initial:
            case FavoriteBooksStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case FavoriteBooksStatus.success:
              if (state.books.isEmpty) {
                return const Center(child: AppText(AppStrings.noFavoritesYet));
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: DndReorderableGrid<Book>(
                  items: _books,
                  crossAxisCount: 2,
                  itemBuilder: (context, book, index) =>
                      BookCard(book: book, heroId: "favorite-${book.id}"),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      final item = _books.removeAt(oldIndex);
                      _books.insert(newIndex, item);
                    });
                  },
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
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
                      state.errorMessage ?? AppStrings.anErrorOccured,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        blocContext
                            .read<FavoriteBooksCubit>()
                            .loadFavoriteBooks();
                      },
                      child: const AppText(AppStrings.retryButtonText),
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
