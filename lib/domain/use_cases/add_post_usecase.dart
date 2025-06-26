import 'package:postsapp/domain/repo/posts_repo.dart';
import '../../core/error/failures.dart';
import '../entities/post.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase {
  final PostsRepo postsRepo;

  AddPostUseCase({required this.postsRepo});

  Future<Either<Failure, Unit>>call(Post post) async {
    return postsRepo.addPosts(post);
  }
}
