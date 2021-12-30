import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/screens/task/widgets/todo_item.dart';
import 'package:check_bird/screens/task/widgets/todo_item_remove.dart';
import 'package:check_bird/widgets/week_day_picker/week_day_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitListScreen extends StatefulWidget {
  static const routeName = '/habit-list-screen';

  const HabitListScreen({Key? key}) : super(key: key);

  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  final TodoListController _controller = TodoListController();
  final Box<Todo> box = TodoListController().getTodoList();
  late final ValueNotifier<List<Todo>> _selectedHabit;
  List<bool> _selectedDays = [true,false,false,false,false,false,false];

  @override
  void initState() {
    super.initState();
    _selectedHabit = ValueNotifier(_controller.getHabitForWeekDays(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Habit List'),
        ),
        body: Column(
          children: [
            const Text(
                "Select days of week",
              style: TextStyle(fontSize: 15),
            ),
            WeekDayPicker(
                onChanged: (days){
                  _selectedDays = days;
                },
                initialValues: _selectedDays
            ),
            const SizedBox(height: 10.0),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: _selectedHabit,
              builder: (context, List<Todo> box, _) {
                final todos = _selectedHabit.value;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return ToDoItemRemove(todos: todos,index: index,isCheck: false);
                  },
                );
              },
            ))
          ],
        ));
  }
}
