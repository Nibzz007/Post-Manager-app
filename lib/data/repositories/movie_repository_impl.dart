import 'package:dartz/dartz.dart';
import 'package:post_manager_app/core/error/failures.dart';
import 'package:post_manager_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';
import 'package:post_manager_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remote;

  MovieRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies({int page = 1}) async {
    try {
      final list = await _remote.getPopularMovies(page: page);
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieEntity>> getMovieById(int id) async {
    try {
      final movie = await _remote.getMovieById(id);
      return Right(movie);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
