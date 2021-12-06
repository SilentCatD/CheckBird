import 'package:check_bird/screens/authentication/authenticate_screen.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:check_bird/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:check_bird/utils/theme.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckBird',
      theme: appTheme,
      home:  const WelcomeScreen(),
      routes: {
        HomeScreen.routeName : (context) => const HomeScreen(),
        AuthenticateScreen.routeName : (context) => const AuthenticateScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
      },
    );
  }
}
