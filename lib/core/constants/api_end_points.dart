import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndPoints {
  static String baseUrl = dotenv.get(
    'BASE_URL',
    fallback: 'https://fallback.url',
  );

  static const String posts = '/posts';
  static String getPostById(int id) => '$posts/$id';
}
