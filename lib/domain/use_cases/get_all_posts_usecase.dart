import '../../core/error/failures.dart';
import '../entities/post.dart';
import '../repo/posts_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostsRepo postsRepo;

  GetAllPostsUseCase({required this.postsRepo});

  Future<Either<Failure, List<Post>>>call() async {
    return postsRepo.getAllPosts();
  }
}
