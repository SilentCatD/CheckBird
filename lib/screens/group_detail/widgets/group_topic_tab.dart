import 'package:check_bird/screens/group_detail/widgets/create_post_screen.dart';
import 'package:flutter/material.dart';

class GroupTopicTab extends StatelessWidget {
  const GroupTopicTab({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreatePostScreen()));
        },
      ),
    );
  }
}
