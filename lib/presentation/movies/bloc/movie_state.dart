part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object?> get props => [];
}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieListLoaded extends MovieState {
  final List<MovieEntity> movies;
  const MovieListLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

final class MovieDetailLoaded extends MovieState {
  final MovieEntity movie;
  const MovieDetailLoaded(this.movie);
  @override
  List<Object?> get props => [movie];
}

final class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);
  @override
  List<Object?> get props => [message];
}
