import 'package:post_manager_app/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> fetchAndSavePosts();
}
