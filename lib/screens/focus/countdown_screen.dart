import 'dart:async';
import 'package:check_bird/screens/focus/button_widget.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class CountDownScreen extends StatefulWidget {
  const CountDownScreen({Key? key, required this.countDownTime}) : super(key: key);
  static const routeName = '/focus-screen';
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
    setState(() {
      final seconds = duration.inSeconds + subSeconds;
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

    timer = Timer.periodic(const Duration(seconds: 1), (_) => subTime());
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Stack(children: <Widget>[
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
                    buildTimer(context),
                    const SizedBox(height: 20),
                    buildButtons(context)
                  ],
                )),
          ]),

        ),
        onWillPop: () async {
          return false;
        }
    );
  }

  Widget buildButtons(BuildContext contextMain) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = (duration.inSeconds == 0);
    if (isRunning || !isCompleted) {
      return ButtonWidget(
        text: 'Cancel',
        onClicked: () {
          stopTimer(reset: false);
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Notification'),
              content: const Text('Do you want to give up'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(contextMain);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    startTime(reset: false);
                    Navigator.pop(context);

                  },
                  child: const Text('No'),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
              text: "Again",
              onClicked: () {
                startTime();
              }),
          const SizedBox(width: 15),
          ButtonWidget(
              text: "Exit",
              onClicked: () {
                Navigator.pop(contextMain);
              }),
        ],
      );
    }
  }

  Widget buildTimer(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: duration.inSeconds / widget.countDownTime.inSeconds,
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 12,
            backgroundColor: Colors.greenAccent,
          ),
          Center(child: buildTime(context)),
        ],
      ),
    );
  }

  Widget buildTime(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inSeconds == 0) {
      return const Icon(Icons.done, color: Colors.greenAccent, size: 112);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimeCard(time: minutes),
          const SizedBox(width: 8),
          buildTimeCard(time: seconds),
        ],
      );
    }
  }

  Widget buildTimeCard({required String time}) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 50,
          ),
        ));
  }
}
