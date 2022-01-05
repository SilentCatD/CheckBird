import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:check_bird/screens/home/widgets/group_item.dart';
import 'package:check_bird/screens/home/widgets/group_more.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  GroupList({Key? key, this.changeTab}) : super(key: key);
  final GroupsController _groupsController = GroupsController();

  final void Function(int index)? changeTab;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _groupsController.usersGroupFuture(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<Group>> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children:[
              GroupMore(changeTab: changeTab!,)
            ],
          );
        }
        final data = snapshot.data;
        if(data == null) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children:[
              GroupMore(changeTab: changeTab!)
            ],
          );
        }
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
          return index == data.length ?
            GroupMore(changeTab: changeTab!)
            : GroupItem(group: data[index])
          ;
        });
        },
    );
  }
}