import 'package:check_bird/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MessageInput extends StatelessWidget {
  const MessageInput({Key? key, required this.ref }) : super(key: key);
  final CollectionReference ref;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      ref.add({
        'text': 'this is a messages',
        'userId': Authentication.user!.uid,
        'created': Timestamp.now(),
      });
    }, child: const Text("Send Message"));
  }
}
