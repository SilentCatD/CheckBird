import 'package:check_bird/screens/group_detail/models/post.dart';
import 'package:check_bird/screens/group_detail/models/posts_controller.dart';
import 'package:check_bird/screens/group_detail/widgets/posts_log/post_item.dart';
import 'package:flutter/material.dart';

GlobalKey<_PostsLogState> postLogKey = GlobalKey();

class PostsLog extends StatefulWidget {
  const PostsLog({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<PostsLog> createState() => _PostsLogState();
}

class _PostsLogState extends State<PostsLog> {

  Future<void> refresh()async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await refresh();
      },
      child: FutureBuilder(
        // stream: PostsController().postsStream(widget.groupId),
        future: PostsController().postsFuture(widget.groupId),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // TODO: this is just temporary solution, in the future, please lookup `ListView.builder JUMPING WHEN SCROLL`
          final posts = snapshot.data!;
          return ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return PostItem(
                postId: posts[index].id!,
                groupId: widget.groupId,
                key: ValueKey(posts[index].id!),
              );
            },

          );
        },
      ),
    );
  }
}
