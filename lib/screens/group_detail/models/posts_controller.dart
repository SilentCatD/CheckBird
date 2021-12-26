import 'package:check_bird/screens/group_detail/models/post.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:ntp/ntp.dart';
import 'package:uuid/uuid.dart';

class PostsController {
  Future<void> getPosts(String groupId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('post')
        .orderBy('createdAt', descending: true)
        .get();
    querySnapshot.docs.forEach((element) {
      print(element.id);
      final data = element.data()! as Map<String, dynamic>;
    });
  }

  Future<String> _sendImg({required File image, required String groupId}) async {
    var ref = FirebaseStorage.instance.ref().child('img').child(groupId).child('post');
    var imgName = const Uuid().v4();
    ref = ref.child('$imgName.jpg');
    TaskSnapshot storageTaskSnapshot = await ref.putFile(image);
    var dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return dowUrl;
  }

  Future<void> createPostInDB({required String groupId,String? text,File? img}) async {
    final db = FirebaseFirestore.instance;
    final ref = db.collection('groups').doc(groupId).collection('post');
    String? imgUrl;
    if(img != null){
      imgUrl = await _sendImg(image: img, groupId: groupId);
    }
    ref.add({
      'info': {
        'createdAt': await NTP.now(),
        'chatCount': 0,
        'likeCount': 0,
        'posterAvatarUrl': Authentication.user!.photoURL,
        'posterName': Authentication.user!.displayName,
        'postText': text,
        'posterImageUrl': imgUrl,
        'posterId': Authentication.user!.uid,
        'posterEmail': Authentication.user!.email,
      },
    });
  }
}
