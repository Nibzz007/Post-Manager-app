import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/post_entity.dart';
import '../../domain/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  // We start the brain in the "Initial" (Sleeping) state
  PostBloc(this.repository) : super(PostInitial()) {
    on<GetPostsEvent>((event, emit) async {
      emit(PostLoading()); // 1. Show the Loading Spinner
      // 2. Ask the Repo to fetch data
      final result = await repository.getPosts();

      // 3. Check if it was successful or not (Right = Success, Left = Failure)
      result.fold(
        (failure) =>
            // If Left (Failure), show the Error State
            emit(PostError(failure.message)),

        (success) =>
            // If Right (Success), show the Loaded State
            emit(PostLoaded(success)),
      );
    });
  }
}
