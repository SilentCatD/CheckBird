import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  static const routeName = '/group-screen';
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Group Screen"),
      ),
      body: const Center(
        child: Text("This is group screen"),
      ),
    );
  }
}
