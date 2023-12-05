import 'package:check_bird/widgets/focus/widgets/countdown/widgets/time_card.dart';
import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay(
      {super.key, required this.countDownTime, required this.duration});
  final Duration duration;
  final Duration countDownTime;

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: duration.inSeconds / countDownTime.inSeconds,
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 12,
            backgroundColor: Colors.greenAccent,
          ),
          Center(
            child: duration.inSeconds == 0
                ? const Icon(Icons.done, color: Colors.greenAccent, size: 112)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimeCard(
                          time: twoDigits(duration.inMinutes.remainder(60))),
                      const SizedBox(width: 8),
                      TimeCard(
                          time: twoDigits(duration.inSeconds.remainder(60))),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
