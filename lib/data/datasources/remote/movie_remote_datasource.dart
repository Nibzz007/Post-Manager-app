import 'package:post_manager_app/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<MovieModel> getMovieById(int id);
}
