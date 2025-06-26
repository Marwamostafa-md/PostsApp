import '../../domain/entities/post.dart';
import '../postmodel/post_model.dart';

extension PostModelMapper on Post {
  PostModel toModel() {
    return PostModel(id: id, title: title, body: body);
  }
}
