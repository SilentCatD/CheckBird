import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/screens/task/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitListScreen extends StatefulWidget {
  static const routeName = '/habit-list-screen';

  const HabitListScreen({Key? key}) : super(key: key);

  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

enum Weekly {
  mo, // monday
  tu, // tuesday
  we, // wednesday
  th, // thursday
  fr, // friday
  sa, // saturday
  su, // sunday
  al
}

class _HabitListScreenState extends State<HabitListScreen> {
  final TodoListController _controller = TodoListController();
  final Box<Todo> box = TodoListController().getTodoList();
  late final ValueNotifier<List<Todo>> _selectedHabit;
  static final Map<Weekly, String> week = {
    Weekly.mo: "Monday",
    Weekly.tu: "Tuesday",
    Weekly.we: "Wednesday",
    Weekly.th: "Thursday",
    Weekly.fr: "Friday",
    Weekly.sa: "Saturday",
    Weekly.su: "Sunday",
    Weekly.al: "All",
  };
  Weekly _pickedWeeklyType = Weekly.mo;

  @override
  void initState() {
    super.initState();
    _pickedWeeklyType = Weekly.mo;
    _selectedHabit =
        ValueNotifier(_controller.getHabitForWeekDays(_pickedWeeklyType.index));
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                        value: _pickedWeeklyType,
                        items: [
                          DropdownMenuItem(
                            child: Text(week.values.toList()[0]),
                            value: Weekly.mo,
                          ),
                          DropdownMenuItem(
                            child: Text(week.values.toList()[1]),
                            value: Weekly.tu,
                          ),
                          DropdownMenuItem(
                            child: Text(week.values.toList()[2]),
                            value: Weekly.we,
                          ),
                          DropdownMenuItem(
                            child: Text(week.values.toList()[3]),
                            value: Weekly.th,
                          ),
                          DropdownMenuItem(
                            child: Text(week.values.toList()[4]),
                            value: Weekly.fr,
                          ),
                          DropdownMenuItem(
                            child: Text(week.values.toList()[5]),
                            value: Weekly.sa,
                          ),
                          DropdownMenuItem(
                            child: Text(week.values.toList()[6]),
                            value: Weekly.su,
                          ),
                          DropdownMenuItem(
                            child: Text(week.values.toList()[7]),
                            value: Weekly.al,
                          ),
                        ],
                        onChanged: (Weekly? value) {
                          setState(() {
                            _pickedWeeklyType = value!;
                          });
                          if (_pickedWeeklyType.index == 7) {
                            _selectedHabit.value = _controller.getAllHabit();
                          } else {
                            _selectedHabit.value = _controller
                                .getHabitForWeekDays(_pickedWeeklyType.index);
                          }
                        })
                  ]),
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
                    return Dismissible(
                      child: TodoItem(todo: todos[index], isCheck: false),
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.cancel),
                      ),
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text("Are you sure?"),
                                  content: const Text(
                                      "You're about to delete habit?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          todos.removeAt(index).deleteTodo();
                                          Navigator.of(context).pop(true);
                                        },
                                        child: const Text("Yes")),
                                  ],
                                ));
                      },
                    );
                  },
                );
              },
            ))
          ],
        ));
  }
}
