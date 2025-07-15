import 'package:books/core/di/locator.dart';
import 'package:books/data/repositories/book_repository.dart';
import 'package:books/presentation/features/books/blocs/search_books_cubit/search_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_screen/app_drawer_icon.dart';
import 'infinite_books_list.dart';
import 'search_header.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookSearchCubit(getIt<BookRepository>()),
      child: const _BooksExploreView(),
    );
  }
}

class _BooksExploreView extends StatefulWidget {
  const _BooksExploreView({super.key});

  @override
  State<_BooksExploreView> createState() => _BooksSearchViewState();
}

class _BooksSearchViewState extends State<_BooksExploreView> {
  void _onSearch(String query) {
    context.read<BookSearchCubit>().search(query);
  }

  void _onLoadMore() {
    context.read<BookSearchCubit>().loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookSearchCubit, BookSearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: AppDrawerIcon(),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text("ExploreScreen"),
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchHeader(onSearch: _onSearch),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InfiniteBooksList(
                      books: state.books,
                      onLoadMore: _onLoadMore,
                      isLoading: state.isInitialLoading,
                      isLoadingMore: state.isLoadingMore,
                      hasMore: state.hasMore,
                      heroPrefix: 'search_',
                      query: state.query, // this is key!
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
