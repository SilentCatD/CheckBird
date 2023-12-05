import 'package:check_bird/screens/group_detail/group_detail_screen.dart';
import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:flutter/material.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GroupDetailScreen(
              group: group,
            )));
      },
      child: SizedBox(
        width: size.width * 0.2,
        child: Column(
          children: [
            CircleAvatar(
              radius: 37,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(group.groupsAvtUrl.toString()),
                backgroundColor: Colors.blueGrey,
              ),
            ),
            Text(group.groupName.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold)
            ),
          ],
        ),
      )
    );
  }
}