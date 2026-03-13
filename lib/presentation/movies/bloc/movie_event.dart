part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object?> get props => [];
}

final class LoadPopularMoviesEvent extends MovieEvent {
  final int page;
  const LoadPopularMoviesEvent({this.page = 1});
}

final class RefreshPopularMoviesEvent extends MovieEvent {}

final class LoadMovieDetailEvent extends MovieEvent {
  final int movieId;
  const LoadMovieDetailEvent(this.movieId);
}
