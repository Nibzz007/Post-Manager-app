import 'package:dartz/dartz.dart';
import 'package:post_manager_app/core/error/failures.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<MovieEntity>>> getFavorites();
  Future<Either<Failure, void>> addFavorite(MovieEntity movie);
  Future<Either<Failure, void>> removeFavorite(int movieId);
  Future<bool> isFavorite(int movieId);
}
