import 'package:check_bird/screens/home/widgets/group_list.dart';
import 'package:check_bird/screens/home/widgets/list_todo_today.dart';
import 'package:check_bird/screens/home/widgets/quotes.dart';
import 'package:check_bird/screens/task/widgets/show_date.dart';
import 'package:check_bird/services/notification.dart';
import 'package:check_bird/utils/theme.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:check_bird/widgets/focus/focus_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key, this.changeTab});
  final void Function(int index)? changeTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    NotificationService().requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeKeys? currentThemeKey = AppTheme.of(context).getCurrentThemeKey();

    final Color colorAppbar;
    if (currentThemeKey == AppThemeKeys.dark) {
      colorAppbar = Colors.deepPurple;
    } else {
      colorAppbar = Colors.white;
    }
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: colorAppbar,
          centerTitle: true,
          title: CircleAvatar(
            backgroundColor: colorAppbar,
            foregroundColor: colorAppbar,
            child: Image.asset(
              'assets/images/checkbird-logo.png',
            ),
          ),
          actions: const [
            FocusButton(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const QuotesAPI(),
              if (Authentication.user != null)
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  height: size.height * 0.17,
                  child: GroupList(changeTab: widget.changeTab!),
                ),
              const ShowDate(text: "To Do In Today"),
              ToDoListToday(today: DateTime.now())
            ],
          ),
        ));
  }
}
