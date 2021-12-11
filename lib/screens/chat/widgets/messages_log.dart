import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/screens/chat/models/message_provider.dart';
import 'package:check_bird/screens/chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';


class MessagesLog extends StatelessWidget {
  const MessagesLog({Key? key, required this.chatScreenArguments}) : super(key: key);
  final ChatScreenArguments chatScreenArguments;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: MessageProvider().messagesStream(chatScreenArguments.chatType, chatScreenArguments.groupId, chatScreenArguments.topicId),
      builder: (BuildContext context, AsyncSnapshot<List<Message>> messages) {
        if (messages.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }
        return ListView.builder(itemBuilder: (context, index) {
          return MessageBubble(message: messages.data![index].text, isMe: messages.data![index].isMe);
        },
          reverse: true,
          itemCount: messages.data!.length,
        );
      },
    );
  }
}
