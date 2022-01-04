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
  String? groupsAvtUrl;
  List<Todo>? tasks;
  int numOfTasks;
  Timestamp createdAt;

  Group({
    required this.groupName,
    required this.groupId,
    this.groupDescription,
    this.groupsAvtUrl,
    this.tasks,
    required this.numOfMember,
    required this.createdAt,
    required this.numOfTasks,
  });
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
        numOfMember: data['numOfMember'],
        createdAt: data['createdAt'],
        groupsAvtUrl: data['groupsAvtUrl'],
        groupDescription: data['groupDescription'],
        numOfTasks: data['numOfTasks'],
      ));
    }
    return results;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> groupStream(
      {required String groupId}) {
    final db = FirebaseFirestore.instance;
    return db.collection('groups').doc(groupId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> usersGroupsStream() {
    final db = FirebaseFirestore.instance;
    return db
        .collection('users')
        .doc(Authentication.user!.uid)
        .collection('groups')
        .orderBy('joined', descending: true)
        .snapshots();
  }

  Future<List<Group>> usersGroupFuture() async {
    /// Get user's groups at the moment requested
    final db = FirebaseFirestore.instance;
    final snapshot = await db
        .collection('users')
        .doc(Authentication.user!.uid)
        .collection('groups')
        .orderBy('joined', descending: true)
        .get();
    final data = snapshot.docs.toList();
    final List<Group> groups = [];
    for(var group in data){
      groups.add(Group(
        groupName: group['groupName'],
        groupId: group.id,
        numOfMember: group['numOfMember'],
        createdAt: group['createdAt'],
        groupsAvtUrl: group['groupsAvtUrl'],
        groupDescription: group['groupDescription'],
        numOfTasks: group['numOfTasks'],
      ));
    }
    return groups;
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

  Future<void> joinGroup(String groupId) async {
    final db = FirebaseFirestore.instance;
    final groupsDocUser = db
        .collection('users')
        .doc(Authentication.user!.uid)
        .collection('groups')
        .doc(groupId);
    final groupDocGlobal = db.collection('groups').doc(groupId);
    final joined = await isJoined(groupId: groupId);
    if (!joined) {
      db.runTransaction((transaction) async {
        final data = await transaction.get(groupDocGlobal);
        transaction.update(groupDocGlobal, {
          'numOfMember': data['numOfMember'] + 1,
        });
        transaction.set(groupsDocUser, {
          "joined": Timestamp.now(),
        });
      });
    }
  }

  Future<void> unJoinGroup(String groupId) async {
    final db = FirebaseFirestore.instance;
    final groupDocUser = db
        .collection('users')
        .doc(Authentication.user!.uid)
        .collection('groups')
        .doc(groupId);
    final groupDocGlobal = db.collection('groups').doc(groupId);
    db.runTransaction((transaction) async {
      final groupGlobalSnapshot = await transaction.get(groupDocGlobal);
      final data = groupGlobalSnapshot.data();
      transaction.delete(groupDocUser);
      transaction.update(groupDocGlobal, {
        'numOfMember': data?['numOfMember'] - 1,
      });
    });
  }

  Future<void> createGroup(
      {required String groupName,
      String? groupDescription,
      List<Todo>? tasks,
      File? image}) async {
    String? imgDownloadUrl;
    if (image != null) {
      imgDownloadUrl = await _sendImg(image: image);
    }
    // Add to groups
    var _db = FirebaseFirestore.instance;
    final groupId = await _db.collection('groups').add({
      "groupName": groupName,
      "groupDescription": groupDescription,
      "groupsAvtUrl": imgDownloadUrl,
      "numOfMember": 1,
      "createdAt": Timestamp.now(),
      "loweredGroupName": groupName.toLowerCase(),
      "numOfTasks": tasks == null ? 0 : tasks.length,
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
