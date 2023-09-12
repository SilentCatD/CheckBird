import 'dart:async';
import 'package:check_bird/screens/flappy_bird/widgets/barrier.dart';
import 'package:check_bird/screens/flappy_bird/widgets/bird.dart';
import 'package:check_bird/screens/flappy_bird/widgets/dead_dialog.dart';
import 'package:flutter/material.dart';

class FlappyBirdScreen extends StatefulWidget {
  const FlappyBirdScreen({Key? key}) : super(key: key);
  static const routeName = '/flappy-bird-screen';

  @override
  State<FlappyBirdScreen> createState() => _FlappyBirdScreenState();
}

class _FlappyBirdScreenState extends State<FlappyBirdScreen> {
  static double birdY = 0;
  double time = 0;
  double height = 0;
  double initialPos = birdY;
  double gravity = -4.9;
  double velocity = 3;
  bool gameHasStarted = false;
  double birdWidth = 0.1;
  double birdHeight = 0.1;
  int score = 0;

  var barrierX = <double>[2, 2 + 1.5];
  var barrierWidth = 0.5; // out of 2
  var barrierHeight = <List<double>>[
    [0.6, 0.4], // top height, bottom height
    [0.4, 0.6],
  ];

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DeadDialog(
            resetGame: resetGame,
            score: score,
            goBack: goBack,
          );
        });
  }

  void goBack() {
    resetGame();
    Navigator.of(context).pop();
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      // keep barriers moving
      setState(() {
        barrierX[i] -= 0.005;
      });

      // if barrier exits the left part of the screen, keep it looping
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
      barrierX = [2, 2 + 1.5];
      score = 0;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        score += 1;
      });
      if (isDead()) {
        score = 0;
        timer.cancel();
      }
    });
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });
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
      moveMap();
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

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
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
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment(0, birdY),
                        child: Bird(
                          birdY: birdY,
                          birdWidth: birdWidth,
                          birdHeight: birdHeight,
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
                      ),
                      Barrier(
                          barrierHeight: barrierHeight[0][0],
                          barrierWidth: barrierWidth,
                          barrierX: barrierX[0],
                          isBottomBarrier: false),
                      Barrier(
                          barrierHeight: barrierHeight[0][1],
                          barrierWidth: barrierWidth,
                          barrierX: barrierX[0],
                          isBottomBarrier: true),
                      Barrier(
                          barrierHeight: barrierHeight[1][0],
                          barrierWidth: barrierWidth,
                          barrierX: barrierX[1],
                          isBottomBarrier: false),
                      Barrier(
                          barrierHeight: barrierHeight[1][1],
                          barrierWidth: barrierWidth,
                          barrierX: barrierX[1],
                          isBottomBarrier: true),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "SCORE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        '$score',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
