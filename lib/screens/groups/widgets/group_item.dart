import 'package:check_bird/screens/group_detail/group_detail_screen.dart';
import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({Key? key, required this.groupId, required this.size})
      : super(key: key);
  final String groupId;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GroupsController().groupStream(groupId: groupId),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data!.data()!;
        // TODO: put data in groups class
        final group = Group(
          groupName: data['groupName'],
          groupId: groupId,
          numOfMember: data['numOfMember'],
          createdAt: data['createdAt'],
          numOfTasks: data['numOfTasks'],
          groupDescription: data['groupDescription'],
          groupsAvtUrl: data['groupsAvtUrl'],
        );
        return Center(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GroupDetailScreen(
                          group: group,
                        )));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: group.groupsAvtUrl != null
                                  ? Image.network(group.groupsAvtUrl!).image
                                  : null,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * 0.5,
                                  height: 30,
                                  child: Text(
                                    group.groupName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('${group.numOfMember}'),
                                    const Icon(Icons.group),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.info),
                            const SizedBox(
                              width: 10,
                            ),
                            Center(
                              child: SizedBox(
                                width: size.width * 0.6,
                                height: 40,
                                child: Text(
                                  group.groupDescription!,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.checklist),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("${group.numOfTasks} task(s)"),
                          ],
                        )
                      ],
                    ),
                    // Check if joined
                    FutureBuilder(
                      future: GroupsController().isJoined(groupId: groupId),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                            padding: const EdgeInsets.all(10),
                            child: Transform.scale(
                                scale: 2.5,
                                child: snapshot.data!
                                    ? const Icon(Icons.check_box_rounded)
                                    : const Icon(
                                        Icons.check_box_outline_blank)));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
