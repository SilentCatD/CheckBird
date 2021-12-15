import 'package:flutter/material.dart';
import 'package:check_bird/services/authentication.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {
            Authentication.signInWithGoogle();
          },
          child: Row(
            children: [
              Image.asset('assets/images/google-logo.png'),
              SizedBox(width: width * 0.08,),
              const Text(
                "Continue with Google",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          )),
    );
  }
}
