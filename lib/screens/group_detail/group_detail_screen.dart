import 'package:check_bird/screens/group_detail/widgets/group_chat_tab.dart';
import 'package:check_bird/screens/group_detail/widgets/group_info_tab.dart';
import 'package:check_bird/screens/group_detail/widgets/group_topic_tab.dart';
import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:flutter/material.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key, required this.group});
  static const routeName = '/chat-detail-screen';
  final Group group;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title:  Text(group.groupName),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.my_library_books)),
                Tab(icon: Icon(Icons.chat_bubble_outlined)),
                Tab(icon: Icon(Icons.info)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GroupTopicTab(groupId: group.groupId,),
              GroupChatTab(groupId: group.groupId,),
              GroupInfoTab(group: group,),
            ],
          ),
        ),
      ),
    );
  }
}
