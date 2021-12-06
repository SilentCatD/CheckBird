import 'package:check_bird/screens/authentication/authenticate_screen.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  /// A StreamBuilder shall be used here with FirebaseAuth as its stream, which
  /// will then determine the login-state of user and show HomePage or
  /// AuthenticateScreen accordingly.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: snapshot.hasData ? const HomeScreen() : const AuthenticateScreen(),
            transitionBuilder: (child, animation) {
             const begin = Offset(0, 1);
             const end = Offset.zero;
             const curve = Curves.ease;
             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
             return SlideTransition(position: animation.drive(tween), child: child,);
            },
          );
        });
  }
}
