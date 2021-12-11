import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/screens/chat/models/message_provider.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({Key? key, required this.chatScreenArguments})
      : super(key: key);
  final ChatScreenArguments chatScreenArguments;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          MessageProvider().sendChat(
            text: "Hi",
            topicId: chatScreenArguments.topicId,
            groupId: chatScreenArguments.groupId,
            chatType: chatScreenArguments.chatType,
          );
        },
        child: const Text("Send Message"));
  }
}
