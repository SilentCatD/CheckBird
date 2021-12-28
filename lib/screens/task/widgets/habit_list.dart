import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/models/todo/todo_type.dart';
import 'package:check_bird/screens/task/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HabitListScreen extends StatefulWidget {
  static const routeName = '/habit-list-screen';

  const HabitListScreen({Key? key}) : super(key: key);

  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

enum Weekly {
  Mo, // monday
  Tu, // tuesday
  We, // wednesday
  Th, // thursday
  Fr, // friday
  Sa, // saturday
  Su // sunday
}

class _HabitListScreenState extends State<HabitListScreen> {
  final TodoListController _controller = TodoListController();
  final Box<Todo> box = TodoListController().getTodoList();
  late final ValueNotifier<List<Todo>> _selectedHabit;
  static final Map<Weekly, String> week = {
    Weekly.Mo: "Monday",
    Weekly.Tu: "Tuesday",
    Weekly.We: "Wednesday",
    Weekly.Th: "Thursday",
    Weekly.Fr: "Friday",
    Weekly.Sa: "Saturday",
    Weekly.Su: "Sunday",
  };
  Weekly _pickedWeeklyType = Weekly.Mo;

  @override
  void initState() {
    super.initState();
    _pickedWeeklyType = Weekly.Mo;
    _selectedHabit = ValueNotifier(_controller.getHabitForWeekDays(_pickedWeeklyType.index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit List'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text(
              "Day of Week: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton(
                value: _pickedWeeklyType,
                items: [
                  DropdownMenuItem(
                    child: Text(week.values.toList()[0]),
                    value: Weekly.Mo,
                  ),
                  DropdownMenuItem(
                    child: Text(week.values.toList()[1]),
                    value: Weekly.Tu,
                  ),
                  DropdownMenuItem(
                    child: Text(week.values.toList()[2]),
                    value: Weekly.We,
                  ),
                  DropdownMenuItem(
                    child: Text(week.values.toList()[3]),
                    value: Weekly.Th,
                  ),
                  DropdownMenuItem(
                    child: Text(week.values.toList()[4]),
                    value: Weekly.Fr,
                  ),
                  DropdownMenuItem(
                    child: Text(week.values.toList()[5]),
                    value: Weekly.Sa,
                  ),
                  DropdownMenuItem(
                    child: Text(week.values.toList()[6]),
                    value: Weekly.Su,
                  ),
                ],
                onChanged: (Weekly? value) {
                  setState(() {
                    _pickedWeeklyType = value!;
                  });
                  _selectedHabit.value = _controller.getHabitForWeekDays(_pickedWeeklyType.index);
                }
            )]
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
              child: ValueListenableBuilder(
                valueListenable:  _selectedHabit,
                builder: (context, List<Todo> box, _) {
                  final todos = _selectedHabit.value;
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          child: TodoItem(todo: todos[index],isCheck: false),
                          background: Container(
                            color: Colors.blue,
                          ),
                          key: const ValueKey(String),
                        onDismissed: (direction){
                            setState(() {
                              //TO DO Remove habit
                              todos.removeAt(index);
                            });
                        },
                      );
                    },
                  );
                },
              )
          )
        ],
      )
    );
  }
}
