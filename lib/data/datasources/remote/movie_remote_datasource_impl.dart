import 'package:post_manager_app/core/constants/api_end_points.dart';
import 'package:post_manager_app/core/network/dio_client.dart';
import 'package:post_manager_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:post_manager_app/data/models/movie_model.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    final response = await _client.get(
      ApiEndPoints.tmdbPopularMovies,
      baseUrlOverride: ApiEndPoints.tmdbBaseUrl,
      queryParameters: {
        'api_key': ApiEndPoints.tmdbApiKey,
        'page': page,
      },
    );
    final list = response.data['results'] as List<dynamic>? ?? [];
    return list.map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<MovieModel> getMovieById(int id) async {
    final response = await _client.get(
      ApiEndPoints.tmdbMovieDetail(id),
      baseUrlOverride: ApiEndPoints.tmdbBaseUrl,
      queryParameters: {'api_key': ApiEndPoints.tmdbApiKey},
    );
    return MovieModel.fromJson(response.data as Map<String, dynamic>);
  }
}
