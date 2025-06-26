import 'package:postsapp/domain/repo/posts_repo.dart';
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/post.dart';

class UpdatePostUseCase {
  final PostsRepo postsRepo;

  UpdatePostUseCase({required this.postsRepo});

  Future<Either<Failure, Unit>> call(Post post) async {
    return postsRepo.upDatePost(post);
  }
}
