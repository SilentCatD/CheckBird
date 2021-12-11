import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/screens/chat/widgets/message_input.dart';
import 'package:check_bird/screens/chat/widgets/messages_log.dart';
import 'package:flutter/material.dart';
import 'package:check_bird/models/chat_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat-screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatScreenArguments;
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Screen"),),
      body: Column(
        children: [
          Expanded(child: MessagesLog(chatScreenArguments: args,)),
          MessageInput(chatScreenArguments: args,)
        ],
      ),
    );
  }
}
