part of 'add_delete_update_post_bloc.dart';

@immutable
sealed class AddDeleteUpdatePostEvent extends Equatable {}

class AddPost extends AddDeleteUpdatePostEvent {
  final Post post;

  AddPost({required this.post});

  @override
  List<Object?> get props => [post];
}

class DeletePost extends AddDeleteUpdatePostEvent {
  final int id;

  DeletePost({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpDatePost extends AddDeleteUpdatePostEvent {
  final Post post;

  UpDatePost({required this.post});

  @override
  List<Object?> get props => [post];
}
