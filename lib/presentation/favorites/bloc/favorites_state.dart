part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object?> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<MovieEntity> movies;
  const FavoritesLoaded(this.movies);

  Set<int> get ids => movies.map((m) => m.id).toSet();

  @override
  List<Object?> get props => [movies];
}

final class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);
  @override
  List<Object?> get props => [message];
}
