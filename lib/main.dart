import 'package:check_bird/screens/authentication/authenticate_screen.dart';
import 'package:check_bird/screens/flappy_bird/flappy_bird_screen.dart';
import 'package:check_bird/screens/focus/focus_screen.dart';
import 'package:check_bird/screens/group_detail/group_detail_screen.dart';
import 'package:check_bird/screens/groups/groups_screen.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:check_bird/screens/main_navigator/main_navigator_screen.dart';
import 'package:check_bird/screens/not_implemented/not_implemented_screen.dart';
import 'package:check_bird/screens/shop/shop_screen.dart';
import 'package:check_bird/screens/task/task_screen.dart';
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
      initialRoute: FlappyBirdScreen.routeName,//WelcomeScreen.routeName,
      routes: {
        FlappyBirdScreen.routeName: (context) => const FlappyBirdScreen(),
        FocusScreen.routeName: (context) => const FocusScreen(),
        GroupScreen.routeName: (context) => const GroupScreen(),
        ShopScreen.routeName: (context) => const ShopScreen(),
        TaskScreen.routeName: (context) => const TaskScreen(),
        MainNavigatorScreen.routeName: (context) => const MainNavigatorScreen(),
        HomeScreen.routeName : (context) => const HomeScreen(),
        AuthenticateScreen.routeName : (context) => const AuthenticateScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        GroupDetailScreen.routeName: (context) => const GroupDetailScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return const NotImplementedScreen();
        });
      },
    );
  }
}
