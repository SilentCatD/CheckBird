import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({Key? key, required this.birdY}) : super(key: key);
  final double birdY;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset(
        'assets/images/fake-bird.png',
        width: 50,
      ),
    );
  }
}
