import 'package:dartz/dartz.dart';
import 'package:post_manager_app/core/error/failures.dart';
import 'package:post_manager_app/data/datasources/local/favorites_local_datasource.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';
import 'package:post_manager_app/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _local;

  FavoritesRepositoryImpl(this._local);

  @override
  Future<Either<Failure, List<MovieEntity>>> getFavorites() async {
    try {
      final list = await _local.getFavorites();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(MovieEntity movie) async {
    try {
      await _local.addFavorite(movie);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(int movieId) async {
    try {
      await _local.removeFavorite(movieId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    return _local.isFavorite(movieId);
  }
}
