import 'package:check_bird/models/chat/chat_screen_arguments.dart';
import 'package:check_bird/models/chat/chat_type.dart';
import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:check_bird/widgets/chat/chat_widget.dart';
import 'package:flutter/material.dart';

class GroupChatTab extends StatelessWidget {
  const GroupChatTab({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GroupsController().isJoined(groupId: groupId),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        final isJoined = snapshot.data!;
        if(isJoined){
          return ChatWidget(
            args: ChatScreenArguments(groupId: groupId, chatType: ChatType.groupChat),
          );
        }
        else{
          return const Center(child: Text("You must join this group first!"),);
        }
      },
    );
  }
}
