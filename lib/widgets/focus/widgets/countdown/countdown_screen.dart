import 'dart:async';
import 'package:check_bird/widgets/focus/widgets/countdown/widgets/give_up_dialog.dart';
import 'package:check_bird/widgets/focus/widgets/countdown/widgets/timer_button.dart';
import 'package:check_bird/widgets/focus/widgets/countdown/widgets/timer_display.dart';
import 'package:flutter/material.dart';

class CountDownScreen extends StatefulWidget {
  const CountDownScreen({Key? key, required this.countDownTime})
      : super(key: key);
  final Duration countDownTime;

  @override
  _CountDownScreenState createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen> {
  Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void subTime() {
    const subSeconds = -1;
    final seconds = duration.inSeconds + subSeconds;
    setState(() {
      if (seconds < 0) {
        stopTimer(reset: false);
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTime({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(const Duration(milliseconds: 10), (_) => subTime());
  }

  void resetTimer() {
    setState(() => duration = widget.countDownTime);
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  void popScreens(int count) {
    Navigator.of(context).popUntil((_) => count-- <= 0);
  }

  void showConfirmQuitDialog() async {
    stopTimer(reset: false);
    var gaveUp = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const GiveUpDialog();
        });
    if (gaveUp) {
      popScreens(2);
    } else {
      startTime(reset: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/blue.jpg'),
                      fit: BoxFit.cover)),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerDisplay(
                      countDownTime: widget.countDownTime, duration: duration),
                  const SizedBox(height: 20),
                  TimerButton(
                    isRunning: timer != null ? timer!.isActive : false,
                    isCompleted: duration.inSeconds == 0,
                    onAgain: startTime,
                    onExit: () {
                      popScreens(2);
                    },
                    onCancel: () {
                      showConfirmQuitDialog();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        if (duration.inSeconds == 0) {
          popScreens(2);
        } else {
          showConfirmQuitDialog();
        }
        return false;
      },
    );
  }
}
