import 'package:flutter/material.dart';

class DeadDialog extends StatelessWidget {
  const DeadDialog({Key? key, required this.resetGame, required this.score, required this.goBack})
      : super(key: key);
  final Function() resetGame;
  final Function() goBack;
  final int score;

  @override
  Widget build(BuildContext context) {
    return ButtonBarTheme(
      data: const ButtonBarThemeData(alignment: MainAxisAlignment.center),
      child: AlertDialog(
        backgroundColor: Colors.brown,
        title: const Center(
          child: Text(
            "G A M E  O V E R",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Your Score:",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              '$score',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: goBack,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text(
                  "GO BACK",
                  style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: resetGame,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text(
                  "PLAY AGAIN",
                  style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
