import 'package:check_bird/screens/group_detail/models/post.dart';
import 'package:check_bird/screens/group_detail/models/posts_controller.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.postId, required this.groupId})
      : super(key: key);
  final String postId;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Post>(
        stream: PostsController().postStream(groupId: groupId, postId: postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Text(snapshot.data!.postText.toString());
        });
  }
}
