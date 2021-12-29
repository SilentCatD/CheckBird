import 'package:check_bird/screens/group_detail/models/post.dart';
import 'package:check_bird/screens/group_detail/models/posts_controller.dart';
import 'package:check_bird/screens/group_detail/widgets/posts_log/like_button.dart';
import 'package:check_bird/screens/group_detail/widgets/posts_log/post_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostItem extends StatefulWidget {
  const PostItem({Key? key, required this.postId, required this.groupId})
      : super(key: key);
  final String postId;
  final String groupId;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with AutomaticKeepAliveClientMixin {
  String createdAtStr(Timestamp createdAtTS) {
    DateTime createdAt = DateTime.parse(createdAtTS.toDate().toString());
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final sendDate = DateTime(createdAt.year, createdAt.month, createdAt.day);
    DateFormat sendTimeFormat = DateFormat.Hm();
    if (today == sendDate) {
      return sendTimeFormat.format(createdAt);
    } else {
      return sendTimeFormat.add_yMMMd().format(createdAt);
    }
  }
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return StreamBuilder<Post>(
          stream:
              PostsController().postStream(groupId: widget.groupId, postId: widget.postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Card(
                  child: SizedBox(
                    height: 400,
                    width: constraints.maxWidth * 0.9,
                  ),
                ),
              );
            }
            Post post = snapshot.data!;
            return Center(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 20),
                elevation: 3.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: constraints.maxWidth * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Image.network(post.posterAvatarUrl),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.posterName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(createdAtStr(post.createdAt!)),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black54,
                        indent: 20,
                        endIndent: 20,
                      ),
                      if (post.postText != null)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            post.postText!,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (post.posterImageUrl != null)
                        Center(
                          child: SizedBox(
                              height: 300,
                              child: Image.network(post.posterImageUrl!)),
                        ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black54,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LikeButton(
                                postId: widget.postId,
                                groupId: widget.groupId,
                              ),
                              Text(
                                post.likeCount.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PostChatScreen(
                                        postId: widget.postId,
                                        groupId: widget.groupId,
                                        posterName: post.posterName,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.mode_comment_outlined),
                                label: const Text("Chat"),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Text(
                                post.chatCount.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }


}
