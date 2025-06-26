import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:postsapp/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';
import '../../domain/use_cases/get_all_posts_usecase.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(const PostsInitial()) {
    on<GetAllPostsEvent>((event, emit) async {
      emit(LoadingPostState());
      print("loading/////////////////");
      final failureOrPosts = await getAllPostsUseCase();
      failureOrPosts.fold(
        (failure) {
          emit(ErrorPostsState(message: mapFailerTomessage(failure)));
          print("error state/////////////////");
        },
        (posts) {
          print(" Posts loaded successfully/////////////////: ${posts.length}");
          emit(LoadedPostsState(posts: posts));
        },
      );
    });

    on<RefreshPostsEvent>((event, emit) async {
      emit(LoadingPostState());

      final failureOrPosts = await getAllPostsUseCase();
      failureOrPosts.fold(
        (failure) {
          emit(ErrorPostsState(message: mapFailerTomessage(failure)));
        },
        (posts) {
          emit(LoadedPostsState(posts: posts));
        },
      );
    });
  }

  String mapFailerTomessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ("please try again later");
      case EmptyCacheFailure:
        return ("No posts");
      case OffLineFailure:
        return ("Please check your internet connection");
      default:
        return ("Unexpected Error,please try again later");
    }
  }
}
