import 'dart:io';

import 'package:check_bird/models/chat/chat_type.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:check_bird/widgets/chat/models/media_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ntp/ntp.dart';
import 'package:uuid/uuid.dart';

class Message {
  const Message({
    required this.isMe,
    required this.userId,
    required this.created,
    required this.data,
    required this.userImageUrl,
    required this.userName,
    required this.id,
    required this.mediaType,
  });

  final MediaType mediaType;
  final String id;
  final String userName;
  final bool isMe;
  final Timestamp created;
  final String data;
  final String userId;
  final String userImageUrl;
}

class MessagesController {
  CollectionReference _textRef(
      ChatType chatType, String groupId, String? topicId) {
    var db = FirebaseFirestore.instance;
    late CollectionReference ref;
    if (chatType == ChatType.groupChat) {
      ref = db.collection('groups').doc(groupId).collection('chat');
    } else {
      ref = db
          .collection('groups')
          .doc(groupId)
          .collection('topics')
          .doc(topicId!)
          .collection('chat');
    }
    return ref;
  }

  Future<void> sendImg({
    required File image,
    required ChatType chatType,
    required String groupId,
    String? topicId,
  }) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('img')
        .child(groupId)
        .child('group-chat');
    if (chatType == ChatType.topicChat) {
      ref = ref.child(topicId!);
    }
    var imgName = const Uuid().v4();
    ref = ref.child('$imgName.jpg');
    TaskSnapshot storageTaskSnapshot = await ref.putFile(image);
    var dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
    sendChat(
        data: dowUrl,
        chatType: chatType,
        groupId: groupId,
        mediaType: MediaType.image);
  }

  Future<void> sendChat(
      {required String data,
      required ChatType chatType,
      required String groupId,
      String? topicId,
      required MediaType mediaType}) async {
    var ref = _textRef(chatType, groupId, topicId);

    late String type;
    if (mediaType == MediaType.text) {
      type = 'text';
    } else if (mediaType == MediaType.image) {
      type = 'image';
    }
    // If there is send video feature in the future, another if check is needed here
    if (chatType == ChatType.topicChat) {
      var topicRef = FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .collection('post')
          .doc(topicId);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot postSnapshot = await transaction.get(topicRef);
        final data = postSnapshot.data()! as Map<String, dynamic>;
        transaction.update(topicRef, {
          "chatCount": data['chatCount'] + 1,
        });
      });
    }

    await ref.add({
      'type': type,
      'data': data,
      'userId': Authentication.user!.uid,
      'userName': Authentication.user!.displayName,
      'created': await NTP.now(),
      'userImageUrl': Authentication.user!.photoURL,
    });
  }

  Stream<List<Message>> messagesStream(
      ChatType chatType, String groupId, String? topicId) {
    var ref = _textRef(chatType, groupId, topicId);
    return ref.orderBy('created', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((msg) {
        var msgData = msg.data()! as Map<String, dynamic>;
        late MediaType type;
        if (msgData['type'] == 'text') {
          type = MediaType.text;
        } else if (msgData['type'] == 'image') {
          type = MediaType.image;
        }
        return Message(
          mediaType: type,
          id: msg.id,
          created: msgData['created'],
          data: msgData['data'].toString(),
          isMe: Authentication.user!.uid == msgData['userId'],
          userId: msgData['userId'],
          userImageUrl: msgData['userImageUrl'],
          userName: msgData['userName'],
        );
      }).toList();
    });
  }
}
