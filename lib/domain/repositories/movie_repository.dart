import 'package:dartz/dartz.dart';
import 'package:post_manager_app/core/error/failures.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies({int page = 1});
  Future<Either<Failure, MovieEntity>> getMovieById(int id);
}
