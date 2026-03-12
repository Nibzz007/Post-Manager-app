import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = dotenv.get('BASE_URL')
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.responseType = ResponseType.json;

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
