import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({Key? key, required this.time}) : super(key: key);
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        time,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 50,
        ),
      ),
    );
  }
}
