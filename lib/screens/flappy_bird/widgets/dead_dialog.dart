import 'package:flutter/material.dart';

class DeadDialog extends StatelessWidget {
  const DeadDialog({Key? key, required this.resetGame}) : super(key: key);
  final Function() resetGame;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Colors.brown,
      title: const Center(
        child: Text(
          "G A M E  O V E R",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: resetGame,
            style: ElevatedButton.styleFrom(primary: Colors.white),
            child: const Text(
              "PLAY AGAIN",
              style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
