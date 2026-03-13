import 'package:post_manager_app/core/database/database_helper.dart';
import 'package:post_manager_app/data/models/movie_model.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';

import 'favorites_local_datasource.dart';

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final DatabaseHelper _db;

  FavoritesLocalDataSourceImpl(this._db);

  @override
  Future<List<MovieEntity>> getFavorites() async {
    final rows = await _db.getFavorites();
    return rows.map((e) => MovieModel.fromJson(e)).toList();
  }

  @override
  Future<void> addFavorite(MovieEntity movie) async {
    final toAdd = movie is MovieModel
        ? movie.toJson()
        : {
            'id': movie.id,
            'title': movie.title,
            'overview': movie.overview,
            'poster_path': movie.posterPath,
            'release_date': movie.releaseDate,
            'vote_average': movie.voteAverage,
          };
    await _db.addFavorite(toAdd);
  }

  @override
  Future<void> removeFavorite(int movieId) async {
    await _db.removeFavorite(movieId);
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    return _db.isFavorite(movieId);
  }
}
