import 'package:check_bird/screens/focus/button_widget.dart';
import 'package:check_bird/screens/focus/focus_screen.dart';
import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTime{
  final String data;

  InputTime(this.data);
}

class BeforeFocusScreen extends StatefulWidget {
  static const routeName = '/before-focus-screen';

  const BeforeFocusScreen({Key? key}) : super(key: key);

  @override
  _BeforeFocusScreenState createState() => _BeforeFocusScreenState();
}

class _BeforeFocusScreenState extends State<BeforeFocusScreen> {
  TextEditingController inputTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: const Text("Task"),
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: inputTime,
                      decoration:
                          const InputDecoration(labelText: "Enter minutes:"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    ButtonWidget(
                        text: "Start time",
                        onClicked: () {
                          if (inputTime.text.isNotEmpty) {
                            print(inputTime.text);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) {
                               return FocusScreen(countDownTime: Duration(minutes: int.parse(inputTime.text)));
                              })
                            );
                          }
                        })
                  ],
                ))));
  }
}
