part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

final class LoadFavoritesEvent extends FavoritesEvent {}

final class AddFavoriteEvent extends FavoritesEvent {
  final MovieEntity movie;
  const AddFavoriteEvent(this.movie);
  @override
  List<Object?> get props => [movie];
}

final class RemoveFavoriteEvent extends FavoritesEvent {
  final int movieId;
  const RemoveFavoriteEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}
