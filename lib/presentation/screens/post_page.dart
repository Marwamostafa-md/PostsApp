import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/presentation/postsbloc/posts_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is LoadingPostState) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              } else if (state is ErrorPostsState) {
                return Text("${state.message}");
              } else if (state is LoadedPostsState) {
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        ),
                        Divider(),
                      ],
                    );
                  },
                );
              } else {
                return Text("No data");
              }
            },
          ),
        ),
      ),
    );
  }
}
