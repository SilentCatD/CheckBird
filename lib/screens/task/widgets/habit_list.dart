import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/screens/task/widgets/todo_item_remove.dart';
import 'package:check_bird/widgets/week_day_picker/week_day_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitListScreen extends StatefulWidget {
  static const routeName = '/habit-list-screen';

  const HabitListScreen({super.key});

  @override
  State<HabitListScreen> createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  final TodoListController _controller = TodoListController();
  final Box<Todo> box = TodoListController().getTodoList();
  late final ValueNotifier<List<Todo>> _selectedHabit;
  List<bool> _selectedDays = [true, false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _selectedHabit =
        ValueNotifier(_controller.getHabitForMultiDays(_selectedDays));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 12),
        const Text(
          "Select days of week",
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 4),
        WeekDayPicker(
            onChanged: (days) {
              _selectedDays = days;
              _selectedHabit.value =
                  _controller.getHabitForMultiDays(_selectedDays);
            },
            initialValues: _selectedDays),
        const SizedBox(height: 10.0),
        Expanded(
            child: ValueListenableBuilder(
          valueListenable: _selectedHabit,
          builder: (context, List<Todo> box, _) {
            final todos = _selectedHabit.value;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ToDoItemRemove(
                    todos: todos, index: index, isCheck: false);
              },
            );
          },
        ))
      ],
    ));
  }
}
