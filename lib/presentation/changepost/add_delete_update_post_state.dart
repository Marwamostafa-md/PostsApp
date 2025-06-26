part of 'add_delete_update_post_bloc.dart';

@immutable
sealed class AddDeleteUpdatePostState extends Equatable {}

final class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {
  AddDeleteUpdatePostInitial();

  @override
  List<Object?> get props => [];
}

class LoadingAddDeleteUpdatePost extends AddDeleteUpdatePostState {
  @override
  List<Object?> get props => [];
}

class ErrorAddDeleteUpdatePost extends AddDeleteUpdatePostState {
  final String message;

  ErrorAddDeleteUpdatePost({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessageAddDeleteUpdatePost extends AddDeleteUpdatePostState {
  final String messageSuccess;

  MessageAddDeleteUpdatePost({required this.messageSuccess});

  @override
  List<Object?> get props => [messageSuccess];
}
