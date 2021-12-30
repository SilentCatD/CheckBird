import 'package:flutter/material.dart';

class ShowDate extends StatelessWidget {
  const ShowDate({Key? key,required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        color:  Colors.blue,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
      ),
    );
  }
}
