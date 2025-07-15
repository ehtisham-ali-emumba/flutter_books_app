import 'package:books/core/di/locator.dart';
import 'package:books/data/repositories/book_repository.dart';
import 'package:books/presentation/features/books/blocs/search_books_cubit/search_books_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchHeader(onSearch: _onSearch),
              ),
              Expanded(
                child: InfiniteBooksList(
                  books: state.books,
                  onLoadMore: _onLoadMore,
                  isLoading: state.status == BookSearchStatus.loadingMore,
                  hasMore: state.hasMore,
                  heroPrefix: 'search_',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
