import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:check_bird/widgets/focus/widgets/button_widget.dart';
import 'package:check_bird/widgets/focus/widgets/countdown/countdown_screen.dart';

class FocusPopupWidget extends StatefulWidget {
  const FocusPopupWidget({super.key});

  @override
  State<FocusPopupWidget> createState() => _FocusPopupWidgetState();
}

class _FocusPopupWidgetState extends State<FocusPopupWidget> {
  Duration _chosenTime = const Duration(minutes: 5);

  Widget dateTimePickerStart(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 120,
      child: CupertinoTimerPicker(
        initialTimerDuration: _chosenTime,
        mode: CupertinoTimerPickerMode.ms,
        onTimerDurationChanged: (duration) {
          setState(() {
            _chosenTime = duration;
          });
        },
      ),
    );
  }

  void _submit() {
    if (_chosenTime.inMinutes >= 5) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return CountDownScreen(countDownTime: _chosenTime);
          },
        ),
      );
    } else {
      const snackBar = SnackBar(
        content: Text('Time chosen must be at least 5 minutes'),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Choose focus time"),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dateTimePickerStart(context),
            const SizedBox(height: 50),
            ButtonWidget(
              text: "Start time",
              onClicked: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class FocusButton extends StatelessWidget {
  const FocusButton({super.key});

  void _showPopupDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(context).pop(),
                  child: GestureDetector(
                      onTap: () {}, child: const FocusPopupWidget()),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.adjust),
        onPressed: () {
          _showPopupDialog(context);
        });
  }
}
