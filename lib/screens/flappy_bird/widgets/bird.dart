import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({super.key, required this.birdY, required this.birdHeight, required this.birdWidth});
  final double birdWidth;
  final double birdHeight;
  final double birdY;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment(0, (2 * birdY + birdHeight) / (2- birdHeight)),
      child: Image.asset(
        'assets/images/fake-bird.png',
        width: size.height * birdWidth / 2,
        height: size.height * 3 / 4 * birdHeight/ 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
