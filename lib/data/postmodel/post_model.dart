import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({required int id, required String title, required String body})
    : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(id: map["id"], title: map["title"], body: map["body"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "body": body};
  }
}
