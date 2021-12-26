import 'package:check_bird/screens/group_detail/widgets/posts_log/posts_log.dart';
import 'package:flutter/material.dart';

import 'create_post/create_post_screen.dart';

class GroupTopicTab extends StatelessWidget {
  const GroupTopicTab({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PostsLog(groupId: groupId,),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) => CreatePostScreen(groupId: groupId,),
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
                }),
          );
        },
      ),
    );
  }
}
