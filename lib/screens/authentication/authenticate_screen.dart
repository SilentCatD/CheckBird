import 'package:check_bird/screens/authentication/widgets/google_login_button.dart';
import 'package:flutter/material.dart';

class AuthenticateScreen extends StatelessWidget {
  static const routeName = '/authenticate-screen';

  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.5,
            child: Image.asset(
              'assets/images/checkbird-logo.png',
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            "CheckBird",
            style: TextStyle(
              fontSize: 50,
              fontFamily: 'Engagement',
            ),
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          GoogleLoginButton(
            width: size.width * 0.8,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/TODO');
              },
              child: const Text(
                "Continue without an account",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 18,
                ),
              )),
        ],
      ),
    );
  }
}
