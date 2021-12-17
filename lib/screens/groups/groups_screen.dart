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
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Group Screen"),
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
