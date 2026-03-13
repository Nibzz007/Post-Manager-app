import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final Dio _dio;
  final String _baseUrl;

  DioClient(this._dio) : _baseUrl = dotenv.get('BASE_URL') {
    _dio
      ..options.baseUrl = _baseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.responseType = ResponseType.json;

    _dio.options.headers['User-Agent'] = 'PostManagerApp/1.0 (Flutter)';
    _dio.options.headers['Accept'] = 'application/json';

    final apiKey = dotenv.maybeGet('API_KEY');
    if (apiKey != null && apiKey.isNotEmpty && apiKey != 'your_secret_key_here') {
      _dio.options.headers['x-api-key'] = apiKey;
    }

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  /// GET with optional alternate base URL (e.g. for TMDB). When [baseUrlOverride]
  /// is set, [queryParameters] are merged with the request (use for api_key etc.).
  Future<Response> get(
    String url, {
    String? baseUrlOverride,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (baseUrlOverride != null && baseUrlOverride.isNotEmpty) {
      final path = url.startsWith('/') ? url : '/$url';
      final q = queryParameters?.map((k, v) => MapEntry(k, v?.toString() ?? '')) ?? <String, String>{};
      final uri = Uri.parse('$baseUrlOverride$path').replace(queryParameters: q.isNotEmpty ? q : null);
      return _dio.getUri(uri);
    }
    return _dio.get(url, queryParameters: queryParameters);
  }

  // CREATE
  Future<Response> post(String url, {dynamic data}) async {
    return _dio.post(url, data: data);
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
