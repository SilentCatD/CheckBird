import 'package:check_bird/screens/chat/widgets/message_bubble.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesLog extends StatelessWidget {
  const MessagesLog({Key? key, required this.ref}) : super(key: key);
  final CollectionReference ref;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ref.orderBy('created', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) {
            return MessageBubble(
              message: chatDocs[index]['text'],
              isMe: chatDocs[index]['userId'] == Authentication.user!.uid,
            );
          },
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
