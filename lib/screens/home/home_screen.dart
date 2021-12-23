import 'package:check_bird/widgets/focus/focus_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

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
        backgroundColor: Colors.white,
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
      body: const Center(
        child: Text("This is home screen"),
      ),
    );
  }
}
