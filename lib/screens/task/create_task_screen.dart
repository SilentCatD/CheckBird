
import 'package:check_bird/screens/focus/focus-popup.dart';
import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);
  static const routeName = '/create-task-screen';
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  String _name = "";
  DateTime _startTime = DateTime.now();
  Widget nameTask(){
    return TextFormField(
        decoration: const InputDecoration(
            labelText: "Name Task"),
        validator:  (value){
          if(value.toString().isEmpty){
            return "Name task is required!";
          }
          return null;
        },
        onSaved: (value){
          _name = value.toString();
        },
      );
  }

  Widget DateTimePickerStart(){
    return SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        initialDateTime: _startTime,
        mode: CupertinoDatePickerMode.dateAndTime,
        minimumDate: DateTime(DateTime.now().year),
        onDateTimeChanged: (dataTime) =>
          setState(()=> _startTime = dataTime),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_name);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Task"),
        actions: [
          IconButton(
              onPressed: () {
                FocusPopUp.myState.createAlertDialog(context);
              },
              icon: const Icon(Icons.adjust)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("This is task screen"),
          nameTask(),


        ],
      ),
    );
  }
}
