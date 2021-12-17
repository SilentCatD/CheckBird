import 'package:check_bird/models/group_detail_argument.dart';
import 'package:check_bird/screens/group_detail/widgets/group_chat_tab.dart';
import 'package:check_bird/screens/group_detail/widgets/group_info_tab.dart';
import 'package:check_bird/screens/group_detail/widgets/group_topic_tab.dart';
import 'package:flutter/material.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/group-detail-screen';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GroupDetailArgument;
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Fake Group"),
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
              GroupTopicTab(),
              GroupChatTab(groupId: args.groupId,),
              GroupInfoTab(),
            ],
          ),
        ),
      ),
    );
  }
}
