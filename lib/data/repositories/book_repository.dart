import 'package:books/core/network/open_lib_api_client.dart';
import 'package:books/data/models/book.dart';

class BookRepository {
  final OpenLibApiClient apiClient;

  BookRepository(this.apiClient);

  Future<List<Book>> getBooksBySubject(String subject, {int? limit}) async {
    final response = await apiClient.get(
      '/subjects/$subject.json',
      queryParameters: {'limit': limit ?? 10},
    );

    final works = response.data['works'] as List;
    return works.map((json) => Book.fromJson(json)).toList();
  }

  Future<List<Book>> getBestsellers() => getBooksBySubject('bestsellers');
  Future<List<Book>> getHistoryBooks() => getBooksBySubject('history');
  Future<List<Book>> getSciFiBooks() => getBooksBySubject('science_fiction');

  Future<List<Book>> searchBooks(String query, {int offset = 0}) async {
    final response = await apiClient.get(
      '/search.json',
      queryParameters: {'q': query, 'offset': offset, 'limit': 20},
    );

    final docs = response.data['docs'] as List;
    return docs.map((json) => Book.fromJson(json)).toList();
  }
}
