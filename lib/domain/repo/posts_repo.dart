import 'package:postsapp/domain/entities/post.dart';
import'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
abstract class PostsRepo{
  Future<Either<Failure,List<Post>>>getAllPosts();
  Future<Either<Failure,Unit>>addPosts(Post post);
  Future<Either<Failure,Unit>>deletePost(int id);
  Future<Either<Failure,Unit>>upDatePost(Post post);
}