import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:postsapp/domain/use_cases/add_post_usecase.dart';
import 'package:postsapp/domain/use_cases/delete_post_usecase.dart';
import 'package:postsapp/domain/use_cases/update_post_usecase.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/post.dart';

part 'add_delete_update_post_event.dart';

part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final DeletePostUseCase deletePostUseCase;
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  AddDeleteUpdatePostBloc({
    required this.deletePostUseCase,
    required this.addPostUseCase,
    required this.updatePostUseCase,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddPost>((event, emit) async{
      emit(LoadingAddDeleteUpdatePost());
      final failureOrSuccessMessage=await addPostUseCase(event.post);
      failureOrSuccessMessage.fold((failure){
        emit(ErrorAddDeleteUpdatePost(message:mapFailerTomessage(failure)));
      }, (unit){
        emit(MessageAddDeleteUpdatePost(messageSuccess: "Post add successfully"));
      });
    });
    on<DeletePost>((event, emit) async{
      emit(LoadingAddDeleteUpdatePost());
      final failureOrSuccessMessage=await deletePostUseCase(event.id);
      failureOrSuccessMessage.fold((failure){
        emit(ErrorAddDeleteUpdatePost(message:mapFailerTomessage(failure)));
      }, (unit){
        emit(MessageAddDeleteUpdatePost(messageSuccess: "Post delete successfully"));
      });
    });

  on<UpDatePost>((event, emit) async{
  emit(LoadingAddDeleteUpdatePost());
  final failureOrSuccessMessage=await updatePostUseCase(event.post);
  failureOrSuccessMessage.fold((failure){
  emit(ErrorAddDeleteUpdatePost(message:mapFailerTomessage(failure)));
  }, (unit){
  emit(MessageAddDeleteUpdatePost(messageSuccess: "Post update successfully"));
  });
  });
}
  String mapFailerTomessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ("please try again later");
      case OffLineFailure:
        return ("Please check your internet connection");
      default:
        return ("Unexpected Error,please try again later");
    }
  }
}
