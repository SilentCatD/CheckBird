import 'package:check_bird/screens/group_detail/models/posts_controller.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton(
      {Key? key, required this.postId, required this.groupId})
      : super(key: key);
  final String postId;
  final String groupId;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  Widget buildLikeButton({required bool isLiked}){
    return TextButton.icon(
      onPressed: () async {
        await PostsController().likePost(groupId: widget.groupId, postId: widget.postId);
        setState(() {
        });
      },
      icon: isLiked ? const Icon(Icons.thumb_up) : const Icon(Icons.thumb_up_alt_outlined),
      label: const Text("Like"),
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PostsController().isLiked(groupId: widget.groupId, postId: widget.postId),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return buildLikeButton(isLiked: false);
        }
        return buildLikeButton(isLiked: snapshot.data!);
      },
    );
  }
}

