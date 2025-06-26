import 'package:postsapp/core/error/exceptions.dart';
import 'package:postsapp/data/postmodel/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import '../dbhelper/db_helper.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postsModel);
}

class LocalDataSourceImpl implements LocalDataSource {
  final DbHelper dbHelper;

  LocalDataSourceImpl({required this.dbHelper});

  @override
  Future<Unit> cachePosts(List<PostModel> postsModel) async {
    final db = await dbHelper.getDatabase();
    await db.delete("Posts");
    for (final post in postsModel) {
      await db.insert(
        "Posts",
        post.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final db = await dbHelper.getDatabase();
    final List<Map<String, dynamic>> map = await db.query("Posts");
    if (map.isNotEmpty) {
      return List.generate(
        map.length,
        (i) => PostModel.fromJson(map[i]),
      ).toList();
    } else {
     throw EmptyCacheException();
    }
  }
}
