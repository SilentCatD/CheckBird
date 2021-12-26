import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    required this.chatCount,
    this.createdAt,
    required this.likeCount,
    this.posterImageUrl,
    this.postText,
    required this.posterAvatarUrl,
    required this.posterName,
    required this.id,
    required this.posterEmail,
    required this.posterId,
  });

  Timestamp? createdAt;
  String posterName;
  String posterEmail;
  String posterId;
  String posterAvatarUrl;
  String? posterImageUrl; // must have imgUrl or text
  String? postText;
  int likeCount;
  int chatCount;
  String? id; // only needed when interacting with post
}
