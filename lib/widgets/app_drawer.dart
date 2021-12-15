import 'package:check_bird/services/authentication.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.deepPurple,
            height: size.height * 0.3,
          ),
          Expanded(
            child: ListView(
              children:  [
                ListTile(
                  title: const Text("Logout"),
                  leading: const Icon(Icons.logout_rounded),
                  onTap: () => Authentication.signOut(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
