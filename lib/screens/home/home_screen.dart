import 'package:check_bird/screens/focus/focus_screen.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/images/checkbird-logo.png',
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(FocusScreen.routeName);
          }, icon: const Icon(Icons.adjust)),
        ],
      ),
      body: const Center(
        child: Text("This is home screen"),
      ),
    );
  }
}
