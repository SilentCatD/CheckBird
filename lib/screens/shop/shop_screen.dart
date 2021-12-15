import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  static const routeName = '/shop-screen';
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Shop screen"),
      ),
      body: const Center(
        child: Text("This is Shop screen"),
      ),
    );
  }
}
