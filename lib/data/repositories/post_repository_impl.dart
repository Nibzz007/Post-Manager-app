import 'package:dartz/dartz.dart';
import 'package:post_manager_app/core/database/database_helper.dart';
import 'package:post_manager_app/core/network/dio_client.dart';
import 'package:post_manager_app/domain/entities/post_entity.dart';
import 'package:post_manager_app/domain/repositories/post_repository.dart';

import '../../core/constants/api_end_points.dart';
import '../../core/error/failures.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final DioClient dioClient;
  final DatabaseHelper dbHelper;

  PostRepositoryImpl(this.dioClient, this.dbHelper);

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final localData = await dbHelper.getCachedPosts();
      if (localData.isNotEmpty) {
        return Right(localData.map((e) => PostModel.fromJson(e)).toList());
      }
    }

    try {
      final response = await dioClient.get(ApiEndPoints.posts);
      final List data = response.data;
      final posts = data.map((post) => PostModel.fromJson(post)).toList();
      await dbHelper.savePosts(posts.map((post) => post.toJson()).toList());
      return Right(posts);
    } catch (e) {
      final localData = await dbHelper.getCachedPosts();
      if (localData.isNotEmpty) {
        return Right(localData.map((e) => PostModel.fromJson(e)).toList());
      }
      return const Left(ServerFailure());
    }
  }
}
