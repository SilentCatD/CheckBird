import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/widgets/chat/widgets/message_input.dart';
import 'package:check_bird/widgets/chat/widgets/messages_log.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget({Key? key, required this.args}) : super(key: key);
  final ChatScreenArguments args;
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MessagesLog(
            messagesLogController: _controller,
            chatScreenArguments: args,
          ),
        ),
        MessageInput(
          messagesLogController: _controller,
          chatScreenArguments: args,
        )
      ],
    );
  }
}
