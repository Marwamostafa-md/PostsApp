import 'package:postsapp/domain/repo/posts_repo.dart';
import '../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepo postsRepo;

  DeletePostUseCase({required this.postsRepo});

  Future<Either<Failure, Unit>>call(int id) async {
    return postsRepo.deletePost(id);
  }
}
