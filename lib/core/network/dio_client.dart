import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    final baseUrl = dotenv.get('BASE_URL');
    final apiKey = dotenv.maybeGet('API_KEY');

    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.responseType = ResponseType.json;

    // Many APIs return 403 without a proper User-Agent (e.g. JSONPlaceholder CDN)
    _dio.options.headers['User-Agent'] = 'PostManagerApp/1.0 (Flutter)';
    _dio.options.headers['Accept'] = 'application/json';

    // Add API key to headers if set (fixes 403 for APIs that require auth)
    if (apiKey != null && apiKey.isNotEmpty && apiKey != 'your_secret_key_here') {
      _dio.options.headers['x-api-key'] = apiKey;
      // Uncomment if your API uses Bearer token instead:
      // _dio.options.headers['Authorization'] = 'Bearer $apiKey';
    }

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  // CREATE
  Future<Response> post(String url, {dynamic data}) async {
    return await _dio.post(url, data: data);
  }

  // READ
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

  // UPDATE
  Future<Response> put(String url, {dynamic data}) async {
    return await _dio.put(url, data: data);
  }

  // DELETE
  Future<Response> delete(String url, {dynamic data}) async {
    return await _dio.delete(url, data: data);
  }
}
