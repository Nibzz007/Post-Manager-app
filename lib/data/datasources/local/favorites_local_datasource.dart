import 'package:post_manager_app/domain/entities/movie_entity.dart';

abstract class FavoritesLocalDataSource {
  Future<List<MovieEntity>> getFavorites();
  Future<void> addFavorite(MovieEntity movie);
  Future<void> removeFavorite(int movieId);
  Future<bool> isFavorite(int movieId);
}
