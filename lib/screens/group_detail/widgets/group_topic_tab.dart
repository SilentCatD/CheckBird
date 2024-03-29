import 'package:check_bird/screens/group_detail/widgets/posts_log/posts_log.dart';
import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:flutter/material.dart';

import 'create_post/create_post_screen.dart';

class GroupTopicTab extends StatefulWidget {
  const GroupTopicTab({super.key, required this.groupId});
  final String groupId;

  @override
  State<GroupTopicTab> createState() => _GroupTopicTabState();
}

class _GroupTopicTabState extends State<GroupTopicTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GroupsController().isJoined(groupId: widget.groupId),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final isJoined = snapshot.data!;
          if (isJoined) {
            return PostsLog(groupId: widget.groupId);
          } else {
            return const Center(
              child: Text("You must join this group first!"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  CreatePostScreen(
                groupId: widget.groupId,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
