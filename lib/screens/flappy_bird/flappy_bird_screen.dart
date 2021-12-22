import 'dart:async';
import 'package:check_bird/screens/flappy_bird/widgets/bird.dart';
import 'package:check_bird/screens/flappy_bird/widgets/dead_dialog.dart';
import 'package:flutter/material.dart';

class FlappyBirdScreen extends StatefulWidget {
  const FlappyBirdScreen({Key? key}) : super(key: key);
  static const routeName = '/flappy-bird-screen';

  @override
  _FlappyBirdScreenState createState() => _FlappyBirdScreenState();
}

class _FlappyBirdScreenState extends State<FlappyBirdScreen> {
  static double birdY = 0;
  double time = 0;
  double height = 0;
  double initialPos = birdY;
  double gravity = -4.9;
  double velocity = 3;
  bool gameHasStarted = false;

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DeadDialog(
            resetGame: resetGame,
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });
      print(birdY);
      if (birdY > 1) {
        timer.cancel();
      }
      if (birdY < -1) {
        setState(() {
          birdY = -1;
        });
      }
      if (isDead()) {
        timer.cancel();
        _showDialog();
      }
      time += 0.01;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool isDead() {
    if (birdY > 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment(0, birdY),
                        child: Bird(
                          birdY: birdY,
                        ),
                      ),
                      Container(
                        alignment: const Alignment(0, -0.5),
                        child: Text(
                          !gameHasStarted ? "T A P  T O  P L A Y" : "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              flex: 3,
            ),

            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 15,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
