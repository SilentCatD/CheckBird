import 'dart:io';

import 'package:check_bird/screens/group_detail/models/post.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ntp/ntp.dart';
import 'package:uuid/uuid.dart';

class PostsController {
  Future<List<Post>> getPosts(String groupId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('post')
        .orderBy('createdAt', descending: true)
        .get();

    List<Post> results = [];
    for (var element in querySnapshot.docs) {
      final data = element.data()! as Map<String, dynamic>;
      results.add(Post(
        chatCount: data['chatCount'],
        likeCount: data['likeCount'],
        posterAvatarUrl: data['posterAvatarUrl'],
        posterName: data['posterName'],
        id: element.id,
        posterEmail: data['posterEmail'],
        posterId: data['posterId'],
        createdAt: data['createdAt'],
        posterImageUrl: data['posterImageUrl'],
        postText: data['postText'],
      ));
    }
    return results;
  }

  Future<String> _sendImg(
      {required File image, required String groupId}) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('img')
        .child(groupId)
        .child('post');
    var imgName = const Uuid().v4();
    ref = ref.child('$imgName.jpg');
    TaskSnapshot storageTaskSnapshot = await ref.putFile(image);
    var dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return dowUrl;
  }

  Future<void> createPostInDB(
      {required String groupId, String? text, File? img}) async {
    final db = FirebaseFirestore.instance;
    final ref = db.collection('groups').doc(groupId).collection('post');
    String? imgUrl;
    if (img != null) {
      imgUrl = await _sendImg(image: img, groupId: groupId);
    }
    ref.add({
      'createdAt': await NTP.now(),
      'chatCount': 0,
      'likeCount': 0,
      'posterAvatarUrl': Authentication.user!.photoURL,
      'posterName': Authentication.user!.displayName,
      'postText': text,
      'posterImageUrl': imgUrl,
      'posterId': Authentication.user!.uid,
      'posterEmail': Authentication.user!.email,
    });
  }

  Stream<Post> postStream({required String groupId, required String postId}) {
    final _ref = FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('post')
        .doc(postId);
    return _ref.snapshots().map((snapshot){
      var data = snapshot.data()!;
      return Post(
        chatCount: data['chatCount'],
        likeCount: data['likeCount'],
        posterAvatarUrl: data['posterAvatarUrl'],
        posterName: data['posterName'],
        id: snapshot.id,
        posterEmail: data['posterEmail'],
        posterId: data['posterId'],
        createdAt: data['createdAt'],
        posterImageUrl: data['posterImageUrl'],
        postText: data['postText'],
      );
    });
  }
}
