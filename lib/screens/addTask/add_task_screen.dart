import 'package:check_bird/models/todo/todo_type.dart';
import 'package:check_bird/screens/addTask/widgets/button_date.dart';
import 'package:check_bird/screens/addTask/widgets/button_date_time.dart';
import 'package:check_bird/screens/addTask/widgets/description_task_input.dart';
import 'package:check_bird/screens/addTask/widgets/name_task_input.dart';
import 'package:check_bird/screens/addTask/widgets/repeat_habit.dart';
import 'package:check_bird/screens/addTask/widgets/notification_task.dart';
import 'package:check_bird/screens/addTask/widgets/title_switch.dart';
import 'package:check_bird/screens/test/widgets/week_day_picker/week_day_picker.dart';
import 'package:check_bird/widgets/focus/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
  static const routeName = '/add-task-screen';

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  String? name;
  String? description;
  TodoType type = TodoType.habit;
  DateTime? notification;
  DateTime? dueTime;
  DateTime? startAfter;
  List<bool>? weekdays;
  // Color ??


  DateTime startAfterTemp = DateTime.now();
  DateTime dueTimeTemp = DateTime.now();
  bool isTask = false;
  bool isNotification = false;
  String dropdownValue = 'Everyday';
  String dropdownTask = 'That Day';
  var items = ['Everyday','Weekly','Custome'];
  var itemsDays = ['That Day','1 Day','2 Day','3 Day'];
  var itemsDaysTemp = ['That Day'];



  void setNotificationTask(){
    switch(dropdownTask){
      case '3 Day':
        notification = DateTime(dueTime!.year,dueTime!.month,dueTime!.day - 3,dueTime!.hour,dueTime!.minute,dueTime!.second);
        break;
      case '2 Day':
        notification = DateTime(dueTime!.year,dueTime!.month,dueTime!.day - 2,dueTime!.hour,dueTime!.minute,dueTime!.second);
        break;
      case '1 Day':
        notification = DateTime(dueTime!.year,dueTime!.month,dueTime!.day - 1,dueTime!.hour,dueTime!.minute,dueTime!.second);
        break;
      case 'That Day':
        notification = DateTime(dueTime!.year,dueTime!.month,dueTime!.day,dueTime!.hour,dueTime!.minute,dueTime!.second);
        break;
    }
  }

  void repeatHabit(){
    weekdays = [false, false, false, false, false, false, false];
    switch(dropdownValue){
      case 'Everyday':
        for(int i = 0 ; i< 7;i++){
          weekdays![i] = true;
        }
        break;
      case 'Weekly':
        weekdays![startAfter!.weekday - 1] = true;
        break;
    }
  }

  void checkDayValidNotification(){
    dropdownTask = 'That Day';
    itemsDaysTemp =['That Day'];
    var difference = dueTimeTemp.difference(DateTime.now()).inDays;
    if(difference >=3 ) {
      difference = 3;
    }
    for(int i = 1 ; i < difference + 1;i++){
      itemsDaysTemp.add(itemsDays[i]);
    }

  }

  void autoFillDate(){
    print("Hello");
    setState(() {
      startAfter ??= DateTime.now();
    });

  }

  void autoFillDateTime(){
    print("Hi");
    dueTime ??= DateTime.now();
  }


  Widget buildSaveButton(){
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 100),
        child: ButtonWidget(text: "Save", onClicked: () {
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            print(name);
            print(description);
            print(dueTime);
            print(type);
            print(weekdays);
            print(notification);
          }
        })
    );
  }


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
          title: const Text("Create task"),
        ),
        body:SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NameTaskInput(onChange: (value) => setState(() => name = value )),
                  const SizedBox(height: 10),
                  DescriptionTaskInput(onChange: (value) => setState(() => description = value )),
                  //TO DO COLOR



                  TitleSwitch(
                      text: "Task",
                      isTrue: isTask,
                      icon: const Icon(Icons.microwave),
                      onChange: (value) => setState(() {
                        isTask = value;
                        if(value == false){
                          isNotification = value;
                          dueTime = null;
                        }
                        if(value == true){
                          startAfter = null;
                        }
                      })),

                  if(isTask) ButtonDateTime(
                    text: "Due time",
                    dueTime: dueTimeTemp,
                    isNull: dueTime == null,
                    onSheet: autoFillDateTime,
                    onChanged: (dataTime) => setState(() {
                      dueTime = dataTime;
                      dueTimeTemp = dataTime;
                      checkDayValidNotification();
                    }),),


                  if(isTask && dueTime != null) TitleSwitch(
                      isTrue: isNotification,
                      text: "Notification",
                      icon: const Icon(Icons.circle_notifications),
                      onChange: (value) => setState(() {
                        isNotification = value;
                      })
                  ),

                  // Task
                  if(isNotification && isTask && dueTime != null) NotificationTask(
                    items: itemsDaysTemp,
                    dropdownTask: dropdownTask,
                    onChange: (String? newValue) {
                      setState(() {
                        dropdownTask = newValue!;
                        setNotificationTask();
                      });
                    },
                  ),

                  //Habit
                  if(!isTask) ButtonDate(
                    text: "Start time",
                    dueTime: startAfterTemp,
                    isNull: startAfter == null,
                    onSheet: autoFillDate,
                    onChanged: (dataTime) => setState(() {
                      startAfter = dataTime;
                      startAfterTemp = dataTime;
                      repeatHabit();
                    }),),
                  if(!isTask && startAfter != null) RepeatHabit(
                    items: items,
                    dropdownValue: dropdownValue,
                    onChange: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        repeatHabit();
                      });
                    },
                  ),

                  if(dropdownValue == "Custome") WeekDayPicker(onChanged: (days) => weekdays = days),

                  buildSaveButton(),
                ],
              ),
            ),
        )
    );
  }
}
