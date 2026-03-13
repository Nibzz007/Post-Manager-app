import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';
import 'package:post_manager_app/domain/repositories/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _repository;

  FavoritesBloc(this._repository) : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoad);
    on<AddFavoriteEvent>(_onAdd);
    on<RemoveFavoriteEvent>(_onRemove);
  }

  Future<void> _onLoad(LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    final result = await _repository.getFavorites();
    result.fold(
      (f) => emit(FavoritesError(f.message)),
      (list) => emit(FavoritesLoaded(list)),
    );
  }

  Future<void> _onAdd(AddFavoriteEvent event, Emitter<FavoritesState> emit) async {
    await _repository.addFavorite(event.movie);
    add(LoadFavoritesEvent());
  }

  Future<void> _onRemove(RemoveFavoriteEvent event, Emitter<FavoritesState> emit) async {
    await _repository.removeFavorite(event.movieId);
    add(LoadFavoritesEvent());
  }
}
