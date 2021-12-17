import 'package:check_bird/models/chat_type.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  const Message({
    required this.isMe,
    required this.userId,
    required this.created,
    required this.text,
    required this.userImageUrl,
    required this.userName,
    required this.id,
  });
  final String id;
  final String userName;
  final bool isMe;
  final Timestamp created;
  final String text;
  final String userId;
  final String userImageUrl;
}

class MessageProvider {
  CollectionReference _ref(ChatType chatType, String groupId, String? topicId) {
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

  Future<void> sendChat(
      {required String text,
      required ChatType chatType,
      required String groupId,
      String? topicId}) async {
    var ref = _ref(chatType, groupId, topicId);
    await ref.add({
      'text': text,
      'userId': Authentication.user!.uid,
      'userName': Authentication.user!.displayName,
      'created': Timestamp.now(),
      'userImageUrl': Authentication.user!.photoURL,
    });
  }

  Stream<List<Message>> messagesStream(
      ChatType chatType, String groupId, String? topicId) {
    var ref = _ref(chatType, groupId, topicId);
    return ref.orderBy('created', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((msg) {
        var msgData = msg.data()! as Map<String, dynamic>;
        return Message(
          id: msg.id,
          created: msgData['created'],
          text: msgData['text'].toString(),
          isMe: Authentication.user!.uid == msgData['userId'],
          userId: msgData['userId'],
          userImageUrl: msgData['userImageUrl'],
          userName: msgData['userName'],
        );
      }).toList();
    });
  }
}
