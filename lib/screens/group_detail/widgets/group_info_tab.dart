import 'package:flutter/material.dart';

class GroupInfoTab extends StatelessWidget {
  const GroupInfoTab({Key? key, required this.groupId}) : super(key: key);
  final String groupId;
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is chat info tab"),
    );
  }
}
