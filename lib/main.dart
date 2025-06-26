import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/presentation/changepost/add_delete_update_post_bloc.dart';
import 'package:postsapp/presentation/postsbloc/posts_bloc.dart';
import 'package:postsapp/presentation/screens/post_page.dart';
import 'injection_container.dart' as di;

void main() async {
  print("app started");
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.getIt<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.getIt<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: PostsPage()),
    ),
  );
}
