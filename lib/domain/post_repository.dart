import 'package:dartz/dartz.dart';
import 'package:post_manager_app/domain/entities/post_entity.dart';

import '../core/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
}
