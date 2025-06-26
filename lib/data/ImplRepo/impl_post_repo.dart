import 'package:dartz/dartz.dart';
import 'package:postsapp/core/error/exceptions.dart';
import 'package:postsapp/core/error/failures.dart';
import 'package:postsapp/core/network/network_info.dart';
import 'package:postsapp/data/mapper/to_post_model.dart';
import 'package:postsapp/domain/entities/post.dart';
import 'package:postsapp/domain/repo/posts_repo.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';

class ImplPostRepo implements PostsRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ImplPostRepo({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        await localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        try {
          final localPosts = await localDataSource.getCachedPosts();
          return Right(localPosts);
        } on EmptyCacheException {
          return Left(EmptyCacheFailure());
        }
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPosts(Post post) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addPosts(post.toModel());
        return Right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deletePost(id);
        return Right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> upDatePost(Post post) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.upDatePost(post.toModel());
        return Right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
