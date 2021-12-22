import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  const Barrier({
    Key? key,
    required this.barrierHeight,
    required this.barrierWidth,
    required this.barrierX,
    required this.isBottomBarrier,
  }) : super(key: key);
  final bool isBottomBarrier;
  final double barrierX;
  final double barrierHeight;
  final double barrierWidth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isBottomBarrier ? 1 : -1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: isBottomBarrier ? const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)): const BorderRadius.only(
              bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
        width: size.width * barrierWidth / 2,
        height: size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
