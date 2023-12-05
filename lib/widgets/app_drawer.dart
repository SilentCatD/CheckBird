import 'package:check_bird/screens/about/about_screen.dart';
import 'package:check_bird/screens/setting/setting_screen.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.secondary,
            height: size.height * 0.4,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: Authentication.user == null
                        ? null
                        : NetworkImage(Authentication.user!.photoURL!),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    Authentication.user == null
                        ? "Not available"
                        : Authentication.user!.displayName!,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    Authentication.user == null
                        ? "Not available"
                        : Authentication.user!.email!,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // TODO: Profile Screen
                // ListTile(
                //   title: const Text("Profile"),
                //   leading: const Icon(Icons.account_circle_rounded),
                //   onTap: () {
                //     Navigator.of(context).pop();
                //     Navigator.of(context).pushNamed('/TODO');
                //   },
                // ),
                ListTile(
                  title: const Text("Setting"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(SettingScreen.routeName);
                  },
                ),
                ListTile(
                  title: const Text("About Us"),
                  leading: const Icon(Icons.people_outline),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(AboutScreen.routeName);
                  },
                ),
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
