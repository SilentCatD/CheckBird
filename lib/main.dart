import 'dart:io';

import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/screens/addTask/add_task_screen.dart';
import 'package:check_bird/screens/authentication/authenticate_screen.dart';
import 'package:check_bird/screens/create_task/create_todo_screen.dart';
import 'package:check_bird/screens/flappy_bird/flappy_bird_screen.dart';
import 'package:check_bird/screens/group_detail/group_detail_screen.dart';
import 'package:check_bird/screens/groups/groups_screen.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:check_bird/screens/main_navigator/main_navigator_screen.dart';
import 'package:check_bird/screens/not_implemented/not_implemented_screen.dart';
import 'package:check_bird/screens/shop/shop_screen.dart';
import 'package:check_bird/screens/task/task_screen.dart';
import 'package:check_bird/screens/test/test_screen.dart';
import 'package:check_bird/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:check_bird/utils/theme.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'models/todo/todo_type.dart';

Future loadLocalData() async {
  await TodoListController().openBox();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Directory directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(TodoTypeAdapter());
  await loadLocalData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckBird',
      theme: appTheme,
      initialRoute: WelcomeScreen.routeName,
      routes: {
        CreateTodoScreen.routeName: (context) => const CreateTodoScreen(),
        TestScreen.routeName: (context) => const TestScreen(),
        FlappyBirdScreen.routeName: (context) => const FlappyBirdScreen(),
        GroupScreen.routeName: (context) => const GroupScreen(),
        ShopScreen.routeName: (context) => const ShopScreen(),
        TaskScreen.routeName: (context) => const TaskScreen(),
        MainNavigatorScreen.routeName: (context) => const MainNavigatorScreen(),
        HomeScreen.routeName : (context) => const HomeScreen(),
        AuthenticateScreen.routeName : (context) => const AuthenticateScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        GroupDetailScreen.routeName: (context) => const GroupDetailScreen(),
        AddTaskScreen.routeName: (context) => const AddTaskScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return const NotImplementedScreen();
        });
      },
    );
  }
}
