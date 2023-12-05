import 'package:flutter/material.dart';
import 'package:check_bird/widgets/focus/widgets/button_widget.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({super.key,
    required this.onCancel,
    required this.isRunning,
    required this.isCompleted,
    required this.onAgain,
    required this.onExit});
  final bool isRunning;
  final bool isCompleted;
  final void Function() onAgain;
  final void Function() onExit;
  final void Function() onCancel;


  @override
  Widget build(BuildContext context) {
    return isRunning || !isCompleted ? ButtonWidget(
      text: 'Cancel',
      onClicked: onCancel,
    ) : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
          text: "Again",
          onClicked: onAgain,
        ),
        const SizedBox(width: 15),
        ButtonWidget(
          text: "Exit",
          onClicked: onExit,
        ),
      ],
    );
  }
}
