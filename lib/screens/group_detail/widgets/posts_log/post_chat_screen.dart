import 'package:check_bird/models/chat/chat_screen_arguments.dart';
import 'package:check_bird/models/chat/chat_type.dart';
import 'package:check_bird/widgets/chat/chat_widget.dart';
import 'package:flutter/material.dart';

class PostChatScreen extends StatelessWidget {
  const PostChatScreen({Key? key, required this.postId, required this.groupId, required this.posterName}) : super(key: key);
  final String groupId;
  final String postId;
  final String posterName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(posterName),
      ),
      body: ChatWidget(
          args: ChatScreenArguments(
              chatType: ChatType.topicChat,
              groupId: groupId,
              topicId: postId)),
    );
  }
}
