import 'package:dio/dio.dart';

class OpenLibApiClient {
  late final Dio dio;

  OpenLibApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://openlibrary.org',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }
}
