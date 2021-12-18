import 'package:check_bird/models/group_detail_argument.dart';
import 'package:check_bird/screens/group_detail/group_detail_screen.dart';
import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  static const routeName = '/groups-screen';

  const GroupScreen({Key? key}) : super(key: key);
  final String groupId = 'ZmxNXfkjyuHlMgYybWmx';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Group"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.group_add)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.adjust)),
        ],
      ),
      body: Center(
        child: ListTile(
          tileColor: Colors.blue,
          onTap: () {
            Navigator.of(context).pushNamed(GroupDetailScreen.routeName, arguments: GroupDetailArgument(groupId: groupId));
          },
          title: const Text('Fake group'),
          subtitle: Text(groupId),
        ),
      ),
    );
  }
}
