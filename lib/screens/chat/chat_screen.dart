import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/screens/chat/widgets/message_input.dart';
import 'package:check_bird/screens/chat/widgets/messages_log.dart';
import 'package:flutter/material.dart';
import 'package:check_bird/models/chat_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat-screen';
  const ChatScreen({Key? key}) : super(key: key);


  CollectionReference _refOf({required String groupId,  String? topicId, required ChatType chatType}) {
    if (chatType == ChatType.groupChat) {
      return FirebaseFirestore.instance.collection('groups').doc(groupId).collection('chat');
    }
    else{
      return FirebaseFirestore.instance.collection('groups').doc(groupId).collection('topics').doc(topicId).collection('chat');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatScreenArguments;
    final _ref = _refOf(groupId: args.groupId, topicId: args.topicId, chatType: args.chatType);
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Screen"),),
      body: Column(
        children: [
          Expanded(child: MessagesLog(ref: _ref,)),
          MessageInput(ref: _ref)
        ],
      ),
    );
  }
}
