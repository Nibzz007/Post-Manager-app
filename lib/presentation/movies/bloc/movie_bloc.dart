import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';
import 'package:post_manager_app/domain/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _repository;

  MovieBloc(this._repository) : super(MovieInitial()) {
    on<LoadPopularMoviesEvent>(_onLoadPopular);
    on<RefreshPopularMoviesEvent>(_onRefreshPopular);
    on<LoadMovieDetailEvent>(_onLoadDetail);
  }

  Future<void> _onLoadPopular(LoadPopularMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await _repository.getPopularMovies(page: event.page);
    result.fold(
      (f) => emit(MovieError(f.message)),
      (movies) => emit(MovieListLoaded(movies)),
    );
  }

  Future<void> _onRefreshPopular(RefreshPopularMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await _repository.getPopularMovies(page: 1);
    result.fold(
      (f) => emit(MovieError(f.message)),
      (movies) => emit(MovieListLoaded(movies)),
    );
  }

  Future<void> _onLoadDetail(LoadMovieDetailEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await _repository.getMovieById(event.movieId);
    result.fold(
      (f) => emit(MovieError(f.message)),
      (movie) => emit(MovieDetailLoaded(movie)),
    );
  }
}
