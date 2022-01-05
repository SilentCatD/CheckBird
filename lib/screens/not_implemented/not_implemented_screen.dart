import 'package:flutter/material.dart';

class NotImplementedScreen extends StatelessWidget {
  const NotImplementedScreen({Key? key}) : super(key: key);
  static const routeName = '/TODO';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/under-construction.png', fit: BoxFit.cover,),
              const Text("This screen is not implemented yet",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  label:  Text("Go back", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Theme.of(context).shadowColor),))
            ],
          ),
        ),
      ),
    );
  }
}
