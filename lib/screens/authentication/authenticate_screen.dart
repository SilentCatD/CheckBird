import 'package:check_bird/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:check_bird/services/authentication.dart';

class AuthenticateScreen extends StatelessWidget {
  static const routeName = '/authenticate-screen';
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authenticate"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              child: const Text("Use a local account"),
            ),
            ElevatedButton.icon(
              icon: const FaIcon(FontAwesomeIcons.google),
              onPressed: () async {
                await Authentication.signInWithGoogle();
              },
              label: const Text("Continue with a Google account"),
            ),
          ],
        ),
      ),
    );
  }
}
