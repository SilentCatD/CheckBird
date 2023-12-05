import 'package:check_bird/screens/authentication/widgets/google_login_button.dart';
import 'package:check_bird/screens/flappy_bird/flappy_bird_screen.dart';
import 'package:flutter/material.dart';

class AuthenticateScreen extends StatelessWidget {
  static const routeName = '/authenticate-screen';

  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(FlappyBirdScreen.routeName),
              child: Container(
                height: size.height * 0.5,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/images/checkbird-logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            const Text(
              "CheckBird",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Engagement',
              ),
            ),
            const Spacer(),
            const GoogleLoginButton(),
            SizedBox(
              height: size.height * 0.03,
            ),
            // NOTE: Disable login without an account feature
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pushNamed('/TODO');
            //   },
            //   child: const Text(
            //     "Continue without an account",
            //     style: TextStyle(
            //       decoration: TextDecoration.underline,
            //       color: Colors.black,
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
