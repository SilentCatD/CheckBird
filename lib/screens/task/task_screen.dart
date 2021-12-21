import 'package:check_bird/screens/focus/focus_screen.dart';
import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  static const routeName = '/task-screen';

  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Task"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FocusScreen.routeName);
              },
              icon: const Icon(Icons.adjust)),
        ],
      ),
      body: const Center(
        child: Text("This is task screen"),
      ),
    );
  }
}
