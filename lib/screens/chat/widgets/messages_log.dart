import 'package:check_bird/screens/chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesLog extends StatelessWidget {
  const MessagesLog({Key? key, required this.ref}) : super(key: key);
  final CollectionReference ref;

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilder: (context, documentSnapshots, index) {
        final data = documentSnapshots[index].data() as Map<String, dynamic>;
        return MessageBubble(data: data);
      },
      query: ref.orderBy('created'),
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
      onEmpty: const Center(child: Text("There's no messages yet"),),
    );
  }
}
