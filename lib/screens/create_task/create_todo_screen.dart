import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/models/todo/todo_type.dart';
import 'package:check_bird/screens/create_task/widgets/create_todo_appbar.dart';
import 'package:check_bird/screens/create_task/widgets/habit_custom.dart';
import 'package:check_bird/screens/create_task/widgets/pick_color.dart';
import 'package:check_bird/screens/create_task/widgets/task_custom.dart';
import 'package:check_bird/screens/create_task/widgets/todo_description_input.dart';
import 'package:check_bird/screens/create_task/widgets/todo_name_input.dart';
import 'package:check_bird/screens/create_task/widgets/toggle_habit_task.dart';
import 'package:flutter/material.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key, this.todo});
  static const routeName = 'create-todo-screen';
  final Todo? todo;

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
  List<bool> _habitLoop = List.filled(7, true);
  var _habitError = false; //
  bool _showWarning = false;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _todoName = widget.todo!.todoName;
      _todoDescription = widget.todo!.todoDescription;
      _backgroundColor = Color(widget.todo!.backgroundColor);
      _textColor = Color(widget.todo!.textColor);
      _todoType = widget.todo!.type;
      _dueDate = widget.todo!.deadline;
      _habitLoop = (widget.todo!.type == TodoType.habit)
          ? widget.todo!.weekdays!
          : _habitLoop;
    }
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    var isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    var hasVal = false;
    for (var i = 0; i < _habitLoop.length; i++) {
      if (_habitLoop[i]) {
        hasVal = true;
        break;
      }
    }
    if (!hasVal) {
      setState(() {
        _habitError = true;
      });
      if (!_showWarning) {
        _showWarning = true;
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _habitError = false;
            _showWarning = false;
          });
        });
      }
      return;
    }
    _formKey.currentState!.save();
    if (widget.todo != null) {
      widget.todo!.editTodo(
        newName: _todoName,
        newDescription: _todoDescription,
        newBackgroundColor: _backgroundColor.value,
        newTextColor: _textColor.value,
        newDeadline: widget.todo!.type == TodoType.habit ? null : _dueDate,
        newNotification:
            widget.todo!.type == TodoType.habit ? null : _notification,
        newWeekdays: widget.todo!.type == TodoType.task ? null : _habitLoop,
      );
    } else {
      if (_todoType == TodoType.habit) {
        TodoListController().addTodo(
          Todo.habit(
            todoName: _todoName,
            todoDescription: _todoDescription,
            textColor: _textColor.value,
            backgroundColor: _backgroundColor.value,
            weekdays: _habitLoop,
          ),
        );
      }
      if (_todoType == TodoType.task) {
        TodoListController().addTodo(
          Todo.task(
              todoName: _todoName,
              todoDescription: _todoDescription,
              textColor: _textColor.value,
              backgroundColor: _backgroundColor.value,
              deadline: _dueDate,
              notification: _notification),
        );
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CreateTodoAppbar(
          todoName: _todoName.isEmpty ? null : _todoName,
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
                  TodoNameInput(
                      todoName: _todoName,
                      onSaved: (value) {
                        _todoName = value;
                      }),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height * 0.25,
                    child: TodoDescriptionInput(
                        todoDescription: _todoDescription,
                        onSaved: (value) {
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
                    onChanged: widget.todo != null
                        ? null
                        : (_) {
                            setState(() {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_todoType == TodoType.habit) {
                                _todoType = TodoType.task;
                              } else {
                                _todoType = TodoType.habit;
                              }
                            });
                          },
                  ),
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
                  if (_todoType == TodoType.habit)
                    HabitCustom(
                      habitDays: widget.todo == null ? null : _habitLoop,
                      onChanged: (values) {
                        _habitLoop = values;
                      },
                    ),
                  if (_todoType == TodoType.habit && _habitError)
                    Text(
                      "Habit required to have at least 1 day",
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    child: widget.todo == null ? const Text("Add todo") : const Text("Save"),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
