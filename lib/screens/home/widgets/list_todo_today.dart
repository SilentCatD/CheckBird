import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/screens/task/widgets/empty_todo.dart';
import 'package:check_bird/screens/task/widgets/show_date.dart';
import 'package:check_bird/screens/task/widgets/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';

class ToDoListToday extends StatelessWidget {
  ToDoListToday({
    Key? key,
    required this.today,
  }) : super(key: key);
  final TodoListController _controller = TodoListController();
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 26),
      child: ValueListenableBuilder(
          valueListenable: _controller.getTodoList().listenable(),
          builder: (context, Box<Todo> box, _) {
            return SingleChildScrollView(
                child: Column(
                    children: [
                      if(_controller.countToDoForDay(today) ==
                          0) const EmptyToDo(),
                      SizedBox(
                        height: size.width * 0.3 *
                            _controller.countToDoForDay(today),
                        child: TodoList(day: today, isToday: true),
                      ),
                    ]
                )
            );
          }
      )
    );
  }
}
