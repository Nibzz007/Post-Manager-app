import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  // We start the brain in the "Initial" (Sleeping) state
  PostBloc(this.repository) : super(PostInitial()) {
    on<GetPostsEvent>(_getPosts);
    on<RefreshPostsEvent>(_getPosts);
  }

  Future<void> _getPosts(PostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final forceRefresh = event is RefreshPostsEvent;
    final result = await repository.getPosts(forceRefresh: forceRefresh);
    result.fold(
      (failure) => emit(PostError(failure.message)),
      (success) => emit(PostLoaded(success)),
    );
  }
}
