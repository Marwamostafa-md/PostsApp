import 'package:postsapp/core/error/exceptions.dart';
import 'package:postsapp/data/postmodel/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../apiconstant/api_constant.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> addPosts(PostModel postModel);

  Future<Unit> deletePost(int id);

  Future<Unit> upDatePost(PostModel postModel);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({required this.dio});

  @override
  Future<Unit> addPosts(PostModel postModel) async {
    final response = await dio.post(
      '${ApiConstant.postsBaseUrl}${ApiConstant.postsEndpoint}',
      data: postModel.toJson(),
    );

    if (response.statusCode == 201) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await dio.delete(
      '${ApiConstant.postsBaseUrl}${ApiConstant.postsEndpoint}/$id',
    );

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await dio.get(
      '${ApiConstant.postsBaseUrl}${ApiConstant.postsEndpoint}',
      options: Options(
        headers: {'Accept': 'application/json', 'User-Agent': 'postsapp/1.0'},
      ),
    );

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> upDatePost(PostModel postModel) async {
    final response = await dio.put(
      '${ApiConstant.postsBaseUrl}${ApiConstant.postsEndpoint}/${postModel.id}',
      data: postModel.toJson(),
    );

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
