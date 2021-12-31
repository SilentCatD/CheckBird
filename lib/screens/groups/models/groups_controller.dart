import 'dart:io';

import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Group {
  String groupId;
  String groupName;
  String? groupDescription;
  int numOfMember;
  bool isJoined;
  String? groupsAvtUrl;
  List<Todo>? tasks;
  late int numOfTasks;
  Timestamp createdAt;

  Group({
    required this.groupName,
    required this.groupId,
    this.groupDescription,
    this.groupsAvtUrl,
    required this.isJoined,
    this.tasks,
    required this.numOfMember,
    required this.createdAt,
  }) {
    numOfTasks = tasks == null ? 0 : tasks!.length;
  }
}

class GroupsController {
  Future<List<Group>> searchGroups({required String query}) async {
    final _db = FirebaseFirestore.instance;
    final searchResults = await _db
        .collection('groups')
        .where('loweredGroupName', isGreaterThanOrEqualTo: query)
        .where('loweredGroupName', isLessThan: query + 'z')
        .get();
    List<Group> results = [];
    for (var group in searchResults.docs.toList()) {
      final data = group.data();
      results.add(Group(
        groupName: data['groupName'],
        groupId: group.id,
        isJoined: await isJoined(groupId: group.id),
        numOfMember: data['numOfMember'],
        createdAt: data['createdAt'],
        groupsAvtUrl: data['groupsAvtUrl'],
        groupDescription: data['groupDescription'],
      ));
    }
    return results;
  }

  Future<List<Group>> usersGroups() async {
    final userId = Authentication.user!.uid;
    final db = FirebaseFirestore.instance;
    final usersGroupId =
        await db.collection('users').doc(userId).collection('groups').get();
    final List<Group> results = [];
    for (var element in usersGroupId.docs) {
      final groupId = element.id;
      final group = await db.collection('groups').doc(groupId).get();
      final data = group.data()!;
      results.add(Group(
        groupName: data['groupName'],
        groupId: element.id,
        isJoined: await isJoined(groupId: element.id),
        numOfMember: data['numOfMember'],
        createdAt: data['createdAt'],
        groupsAvtUrl: data['groupsAvtUrl'],
        groupDescription: data['groupDescription'],
      ));
    }
    return results;
  }

  Future<bool> isJoined({required String groupId}) async {
    final groupDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(Authentication.user!.uid)
        .collection('groups')
        .doc(groupId)
        .get();
    return groupDoc.exists;
  }

  Future<String> _sendImg({required File image}) async {
    var ref = FirebaseStorage.instance.ref().child('img').child('groups');
    var imgName = const Uuid().v4();
    ref = ref.child('$imgName.jpg');
    TaskSnapshot storageTaskSnapshot = await ref.putFile(image);
    var dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return dowUrl;
  }

  Future<void> createGroup(
      {required String groupName,
      String? groupDescription,
      List<Todo>? tasks,
      File? image}) async {
    String? imgDownloadUrl;
    if (image != null) {
      // TODO
      imgDownloadUrl = await _sendImg(image: image);
    }
    // Add to groups
    var _db = FirebaseFirestore.instance;
    final groupId = await _db.collection('groups').add({
      "groupName": groupName,
      "groupDescription": groupDescription,
      "groupsAvtUrl": imgDownloadUrl,
      "numOfMember": 0,
      "createdAt": Timestamp.now(),
      "loweredGroupName": groupName.toLowerCase(),
    });
    // Add to users
    _db
        .collection('users')
        .doc(Authentication.user!.uid)
        .collection('groups')
        .doc(groupId.id)
        .set({
      "joined": Timestamp.now(),
    });
  }
}
