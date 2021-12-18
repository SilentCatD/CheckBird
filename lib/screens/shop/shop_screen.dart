import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  static const routeName = '/shop-screen';
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Shop"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.adjust)),
        ],
      ),
      body: const Center(
        child: Text("This is Shop screen"),
      ),
    );
  }
}
