import 'dart:io';
import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/screens/about/about_screen.dart';
import 'package:check_bird/screens/authentication/authenticate_screen.dart';
import 'package:check_bird/screens/create_task/create_todo_screen.dart';
import 'package:check_bird/screens/flappy_bird/flappy_bird_screen.dart';
import 'package:check_bird/screens/groups/groups_screen.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:check_bird/screens/main_navigator/main_navigator_screen.dart';
import 'package:check_bird/screens/not_implemented/not_implemented_screen.dart';
import 'package:check_bird/screens/shop/shop_screen.dart';
import 'package:check_bird/screens/task/task_screen.dart';
import 'package:check_bird/screens/welcome/welcome_screen.dart';
import 'package:check_bird/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:check_bird/utils/theme.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'models/todo/todo_type.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:check_bird/screens/setting/setting_screen.dart';

Future loadLocalData() async {
  await TodoListController().openBox();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Directory directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(TodoTypeAdapter());
  await loadLocalData();
  await NotificationService().initialize();
  await Settings.init(cacheProvider: SharePreferenceCache());
  var appTheme = AppTheme();
  runApp(ChangeNotifierProvider(
    create: (_) => appTheme,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckBird',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.of(context, listen: true).getCurrentTheme(),
      initialRoute: WelcomeScreen.routeName,
      routes: {
        SettingScreen.routeName: (context) => const SettingScreen(),
        CreateTodoScreen.routeName: (context) => const CreateTodoScreen(),
        FlappyBirdScreen.routeName: (context) => const FlappyBirdScreen(),
        GroupScreen.routeName: (context) => const GroupScreen(),
        ShopScreen.routeName: (context) => const ShopScreen(),
        TaskScreen.routeName: (context) => const TaskScreen(),
        MainNavigatorScreen.routeName: (context) => const MainNavigatorScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        AuthenticateScreen.routeName: (context) => const AuthenticateScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        AboutScreen.routeName: (context) => const AboutScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return const NotImplementedScreen();
        });
      },
    );
  }
}
