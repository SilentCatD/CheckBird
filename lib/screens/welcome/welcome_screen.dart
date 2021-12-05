import 'package:check_bird/screens/authentication/authenticate_screen.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class  WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  /// A StreamBuilder shall be used here with FirebaseAuth as it stream, which
  /// will then determine the login-state of user to show HomePage or
  /// AuthenticateScreen accordingly.
  @override
  Widget build(BuildContext context) {
    return const AuthenticateScreen();
  }
}
