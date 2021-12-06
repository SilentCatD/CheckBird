import 'package:check_bird/models/chat_type.dart';

class ChatScreenArguments{
  final String groupId;
  final String? topicId;
  final ChatType chatType;
  const ChatScreenArguments({required this.groupId, this.topicId, required this.chatType});
}