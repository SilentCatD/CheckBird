import 'package:check_bird/models/chat/chat_screen_arguments.dart';
import 'package:check_bird/widgets/chat/models/message_provider.dart';
import 'package:check_bird/widgets/chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class MessagesLog extends StatefulWidget {
  const MessagesLog(
      {Key? key,
      required this.chatScreenArguments,
      required this.messagesLogController})
      : super(key: key);
  final ChatScreenArguments chatScreenArguments;
  final ScrollController messagesLogController;

  @override
  State<MessagesLog> createState() => _MessagesLogState();
}

class _MessagesLogState extends State<MessagesLog> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: MessageProvider().messagesStream(
          widget.chatScreenArguments.chatType,
          widget.chatScreenArguments.groupId,
          widget.chatScreenArguments.topicId),
      builder: (BuildContext context, AsyncSnapshot<List<Message>> messages) {
        if (messages.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: widget.messagesLogController,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    key: ValueKey(messages.data![index].id),
                    message: messages.data![index].data,
                    isMe: messages.data![index].isMe,
                    photoUrl: messages.data![index].userImageUrl,
                    senderName: messages.data![index].userName,
                    sendAt: messages.data![index].created,
                    mediaType: messages.data![index].mediaType,
                  );
                },
                reverse: true,
                itemCount: messages.data!.length,
              ),
            ),
            IconButton(
              onPressed: () {
                widget.messagesLogController.animateTo(
                  widget.messagesLogController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              },
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ],
        );
      },
    );
  }
}
