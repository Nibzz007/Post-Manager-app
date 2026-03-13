import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndPoints {
  static String get baseUrl => dotenv.get('BASE_URL', fallback: 'https://fallback.url');

  // --- Posts (e.g. JSONPlaceholder) ---
  static const String posts = '/posts';
  static String getPostById(int id) => '$posts/$id';

  // --- TMDB (get free key at https://www.themoviedb.org/settings/api) ---
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static String get tmdbApiKey => dotenv.get('TMDB_API_KEY', fallback: '');

  static const String tmdbPopularMovies = '/movie/popular';
  static const String tmdbTrendingMovies = '/trending/movie/day';
  static String tmdbMovieDetail(int id) => '/movie/$id';
}
