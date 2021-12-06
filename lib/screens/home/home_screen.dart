import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/screens/chat/chat_screen.dart';
import 'package:check_bird/screens/welcome/welcome_screen.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:check_bird/models/chat_type.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Authentication.user == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You are local user"),
                  ElevatedButton(
                    onPressed: () async {
                      await Authentication.signOut();
                      Navigator.pushReplacementNamed(
                          context, WelcomeScreen.routeName);
                    },
                    child: const Text("Back to welcome screen"),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You logged in with an account"),
                  ElevatedButton.icon(
                    onPressed: () {
                      const String topicId = 'nX4v5niYcD1BUX4pI7i8';
                      const String groupId = 'ZmxNXfkjyuHlMgYybWmx';
                      const ChatType chatType = ChatType.topicChat;
                      Navigator.pushNamed(
                        context,
                        ChatScreen.routeName,
                        arguments: const ChatScreenArguments(
                          groupId: groupId,
                          topicId: topicId,
                          chatType: chatType,
                        ),
                      );
                    },
                    icon: const FaIcon(FontAwesomeIcons.facebookMessenger),
                    label: const Text("To messages"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Authentication.signOut();
                    },
                    icon: const FaIcon(FontAwesomeIcons.signOutAlt),
                    label: const Text("Sign-out"),
                  ),
                ],
              ),
      ),
    );
  }
}
