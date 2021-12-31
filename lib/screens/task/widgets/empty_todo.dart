import 'package:flutter/material.dart';

class EmptyToDo extends StatelessWidget {
  const EmptyToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color:  Colors.blueAccent,
          ),
          child: const Text(
          "You have nothing to do",
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );

  }
}
