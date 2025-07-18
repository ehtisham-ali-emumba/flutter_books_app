import 'package:books/data/repositories/book_repository.dart';
import 'package:books/presentation/features/books/view_models/book_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SciFiBooksCubit extends Cubit<BookListState> {
  final BookRepository repository;

  SciFiBooksCubit(this.repository) : super(const BookListState());

  Future<void> loadSciFi() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final books = await repository.getSciFiBooks();
      emit(state.copyWith(books: books, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
