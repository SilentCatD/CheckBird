import 'package:check_bird/screens/group_detail/models/post.dart';
import 'package:check_bird/screens/group_detail/models/posts_controller.dart';
import 'package:check_bird/screens/group_detail/widgets/posts_log/post_item.dart';
import 'package:flutter/material.dart';

class PostsLog extends StatefulWidget {
  const PostsLog({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<PostsLog> createState() => _PostsLogState();
}

class _PostsLogState extends State<PostsLog> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PostsController().getPosts(widget.groupId),
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final posts = snapshot.data!;
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return PostItem(postId: posts[index].id!, groupId: widget.groupId,);
            },
          ),
        );
      },
    );
  }
}
