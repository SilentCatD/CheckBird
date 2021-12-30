import 'package:flutter/material.dart';

class EmptyToDo extends StatelessWidget {
  const EmptyToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.blue,
      // decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.all(Radius.circular(10)),
      //   color:  Colors.white,
      // ),
      child: const Text(
        "Empty To Do",
        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
      ),
    );
  }
}
