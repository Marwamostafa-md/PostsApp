import 'package:get_it/get_it.dart';
import 'package:postsapp/core/network/network_info.dart';
import 'package:postsapp/data/ImplRepo/impl_post_repo.dart';
import 'package:postsapp/data/datasources/local_data_source.dart';
import 'package:postsapp/data/datasources/remote_data_source.dart';
import 'package:postsapp/domain/repo/posts_repo.dart';
import 'package:postsapp/domain/use_cases/add_post_usecase.dart';
import 'package:postsapp/domain/use_cases/delete_post_usecase.dart';
import 'package:postsapp/domain/use_cases/get_all_posts_usecase.dart';
import 'package:postsapp/domain/use_cases/update_post_usecase.dart';
import 'package:postsapp/presentation/changepost/add_delete_update_post_bloc.dart';
import 'package:postsapp/presentation/postsbloc/posts_bloc.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'data/dbhelper/db_helper.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => PostsBloc(getAllPostsUseCase: getIt()));
  getIt.registerFactory(
    () => AddDeleteUpdatePostBloc(
      deletePostUseCase: getIt(),
      addPostUseCase: getIt(),
      updatePostUseCase: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => GetAllPostsUseCase(postsRepo: getIt()));
  getIt.registerLazySingleton(() => DeletePostUseCase(postsRepo: getIt()));
  getIt.registerLazySingleton(() => UpdatePostUseCase(postsRepo: getIt()));
  getIt.registerLazySingleton(() => AddPostUseCase(postsRepo: getIt()));
  getIt.registerLazySingleton<PostsRepo>(
    () => ImplPostRepo(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(dio: getIt()),
  );
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(dbHelper: getIt()),
  );
  getIt.registerLazySingletonAsync<Database>(() async {
    final dbHelper = getIt<DbHelper>();
    return await dbHelper.getDatabase();
  });
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: getIt()),
  );
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DbHelper>(() => DbHelper());
  getIt.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
