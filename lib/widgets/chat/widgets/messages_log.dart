import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/widgets/chat/models/message_provider.dart';
import 'package:check_bird/widgets/chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class MessagesLog extends StatelessWidget {
  const MessagesLog({Key? key, required this.chatScreenArguments})
      : super(key: key);
  final ChatScreenArguments chatScreenArguments;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: MessageProvider().messagesStream(chatScreenArguments.chatType,
          chatScreenArguments.groupId, chatScreenArguments.topicId),
      builder: (BuildContext context, AsyncSnapshot<List<Message>> messages) {
        if (messages.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return MessageBubble(
              key: ValueKey(messages.data![index].id),
              message: messages.data![index].text,
              isMe: messages.data![index].isMe,
              photoUrl: messages.data![index].userImageUrl,
            );
          },
          reverse: true,
          itemCount: messages.data!.length,
        );
      },
    );
  }
}
