import 'package:check_bird/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:check_bird/utils/theme.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    );
  }
}
