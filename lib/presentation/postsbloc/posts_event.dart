
part of 'posts_bloc.dart';
@immutable
sealed class PostsEvent {}
class GetAllPostsEvent extends PostsEvent{}
class RefreshPostsEvent extends PostsEvent{}