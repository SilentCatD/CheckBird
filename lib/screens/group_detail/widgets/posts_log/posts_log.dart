import 'package:check_bird/screens/group_detail/models/post.dart';
import 'package:check_bird/screens/group_detail/models/posts_controller.dart';
import 'package:check_bird/screens/group_detail/widgets/posts_log/post_item.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:flutter/material.dart';

class PostsLog extends StatefulWidget {
  const PostsLog({super.key, required this.groupId});
  final String groupId;

  @override
  State<PostsLog> createState() => _PostsLogState();
}

class _PostsLogState extends State<PostsLog> {
  late dynamic newPostStream;
  String? lastPostId;

  Future<void> refresh() async {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    newPostStream =
        PostsController().postsStream(widget.groupId).listen((event) {
      if (event.isNotEmpty &&
          event.first.posterId == Authentication.user!.uid &&
          event.first.id != lastPostId &&
          mounted) {
        setState(() {
          lastPostId = event.first.id;
        });
      }
    });
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
          final posts = snapshot.data;
          if (posts == null || posts.isEmpty) {
            return const Center(
              child: Text("There are no post yet"),
            );
          }
          lastPostId = posts.first.id;
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
