import 'package:check_bird/screens/focus/button_widget.dart';
import 'package:check_bird/screens/focus/countdown_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FocusPopUp extends StatefulWidget {
  static const routeName = '/focus-popup';
  const FocusPopUp({Key? key}) : super(key: key);

  static _FocusPopUpState myState = _FocusPopUpState();


  @override
  _FocusPopUpState createState() => _FocusPopUpState();
}


class _FocusPopUpState extends State<FocusPopUp> {
  Duration dataCountTime = const Duration(minutes: 5);

  Widget DateTimePickerStart() =>
      SizedBox(
          width: 300,
          height: 120,
          child: CupertinoTimerPicker(
            initialTimerDuration: dataCountTime,
            mode: CupertinoTimerPickerMode.ms,
            onTimerDurationChanged: (duration) =>
               dataCountTime = duration,
          )
      );

  createAlertDialog(BuildContext context) {
    return showDialog(context: context, builder: (_) {
      return AlertDialog(
          title: const Text("Choose task"),
          content: Container(
              width: double.infinity,
              height: 350,
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DateTimePickerStart(),
                  const SizedBox(height: 50),
                  ButtonWidget(
                      text: "Start time",
                      onClicked: () {
                        if (dataCountTime.inMinutes >= 5) {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CountDownScreen(
                                        countDownTime: dataCountTime);
                                  })
                          );
                        }
                      })
                ],)
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return createAlertDialog(context);
  }
}