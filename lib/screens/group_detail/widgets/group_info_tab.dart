import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:check_bird/screens/groups/widgets/create_group/create_group_screen.dart';
import 'package:flutter/material.dart';

class GroupInfoTab extends StatelessWidget {
  const GroupInfoTab({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  Widget build(BuildContext context) {
    return CreateGroupScreen(group: group,);
  }
}
