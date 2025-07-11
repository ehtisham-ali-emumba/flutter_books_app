import 'package:books/data/repositories/book_repository.dart';
import 'package:books/presentation/features/books/blocs/book_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestsellerBooksCubit extends Cubit<BookListState> {
  final BookRepository repository;

  BestsellerBooksCubit(this.repository) : super(const BookListState());

  Future<void> loadBestsellers() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final books = await repository.getBestsellers();
      emit(state.copyWith(books: books, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
