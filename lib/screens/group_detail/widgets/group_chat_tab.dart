import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/models/chat_type.dart';
import 'package:check_bird/widgets/chat/chat_widget.dart';
import 'package:flutter/material.dart';

class GroupChatTab extends StatelessWidget {
  const GroupChatTab({Key? key, required this.groupId}) : super(key: key);
  final String groupId;
  @override
  Widget build(BuildContext context) {
    return ChatWidget(
      args: ChatScreenArguments(groupId: groupId, chatType: ChatType.groupChat),
    );
  }
}
