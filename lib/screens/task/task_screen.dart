import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  static const routeName = '/task-screen';
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Task screen"),
      ),
      body: const Center(
        child: Text("This is task screen"),
      ),
    );
  }
}
