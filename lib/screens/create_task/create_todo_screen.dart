import 'package:check_bird/models/todo/todo_type.dart';
import 'package:check_bird/screens/create_task/widgets/create_todo_appbar.dart';
import 'package:check_bird/screens/create_task/widgets/habit_custom/habit_custom.dart';
import 'package:check_bird/screens/create_task/widgets/pick_color.dart';
import 'package:check_bird/screens/create_task/widgets/task_custom/task_custom.dart';
import 'package:check_bird/screens/create_task/widgets/todo_description_input.dart';
import 'package:check_bird/screens/create_task/widgets/todo_name_input.dart';
import 'package:check_bird/screens/create_task/widgets/toggle_habit_task.dart';
import 'package:flutter/material.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({Key? key}) : super(key: key);
  static const routeName = 'create-todo-screen';

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _todoName = "";
  String _todoDescription = "";
  TodoType _todoType = TodoType.task;
  var _backgroundColor = Colors.white;
  var _textColor = Colors.black;
  DateTime? _dueDate;
  DateTime? _notification;

  void _submit() {
    FocusScope.of(context).unfocus();
    var isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    print(_todoName);
    print(_todoDescription);
    print(_backgroundColor);
    print(_textColor);
    print(_todoType);
    print(_dueDate);
    print(_notification);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CreateTodoAppbar(
          appBar: AppBar(),
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TodoNameInput(onSaved: (value) {
                    _todoName = value;
                  }),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height * 0.25,
                    child: TodoDescriptionInput(onSaved: (value) {
                      _todoDescription = value;
                    }),
                  ),
                  PickColor(
                    backgroundColor: _backgroundColor,
                    textColor: _textColor,
                    setBackgroundColor: (color) {
                      setState(() {
                        _backgroundColor = color;
                      });
                    },
                    setTextColor: (color) {
                      setState(() {
                        _textColor = color;
                      });
                    },
                  ),
                  ToggleHabitTask(
                      todoType: _todoType,
                      onChanged: (_) {
                        setState(() {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_todoType == TodoType.habit) {
                            _todoType = TodoType.task;
                          } else {
                            _todoType = TodoType.habit;
                          }
                        });
                      }),
                  if (_todoType == TodoType.task)
                    TaskCustom(
                      initialDate: _dueDate,
                      onChangedDue: (value) {
                        setState(() {
                          _dueDate = DateTime.parse(value);
                        });
                      },
                      onChangedNotification: (value) {
                        _notification = value;
                      },
                    ),
                  if (_todoType == TodoType.habit) const HabitCustom(),
                  ElevatedButton(
                      onPressed: () {
                        _submit();
                      },
                      child: const Text("Add todo"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
