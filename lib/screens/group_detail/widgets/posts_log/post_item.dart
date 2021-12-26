import 'package:check_bird/screens/group_detail/models/post.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.postId, required this.groupId}) : super(key: key);
  final String postId;
  final String groupId;
  @override
  Widget build(BuildContext context) {
    return Text(postId);
  }
}
