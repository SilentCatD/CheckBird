import 'package:check_bird/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  bool get _isMe {
    return data['userId'] == Authentication.user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Row(
        mainAxisAlignment:
        _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: constraint.maxWidth * 0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:
              _isMe ? Theme.of(context).colorScheme.secondary : Colors.grey,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('');
                    }
                    return Text(snapshot.data!['username']);
                  },
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(data['userId'])
                      .get(),
                ),
                Text(
                  data['text'],
                  style: TextStyle(
                    color: _isMe ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
