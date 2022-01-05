import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:check_bird/screens/home/widgets/list_todo_today.dart';
import 'package:check_bird/screens/home/widgets/quotes.dart';
import 'package:check_bird/screens/task/widgets/show_date.dart';
import 'package:check_bird/widgets/focus/focus_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Allow'),
                content: const Text('Check Bird want to send notification'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Don\'t Allow',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () =>
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) => Navigator.pop(context)),
                      child: const Text(
                        'Allow',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: CircleAvatar(
          backgroundColor: Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const QuotesAPI(),
            const ShowDate(text: "To Do In Today"),
            ToDoListToday(today: DateTime.now())
          ],
        ),
      )
    );
  }
}
