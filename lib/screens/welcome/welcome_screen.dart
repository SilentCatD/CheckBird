import 'package:animations/animations.dart';
import 'package:check_bird/screens/authentication/authenticate_screen.dart';
import 'package:check_bird/screens/main_navigator/main_navigator_screen.dart';
import 'package:check_bird/services/authentication.dart';
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
          if (snapshot.hasData) {
            Authentication.user = snapshot.data;
          }
          return PageTransitionSwitcher(
            child: snapshot.hasData
                ? const MainNavigatorScreen()
                : const AuthenticateScreen(),
            transitionBuilder: (Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation) {
              const begin = Offset(1.0, 0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: primaryAnimation.drive(tween),
                child: child,
              );
            },
          );
        });
  }
}
