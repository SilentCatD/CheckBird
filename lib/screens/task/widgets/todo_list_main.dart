import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/screens/task/widgets/empty_todo.dart';
import 'package:check_bird/screens/task/widgets/show_date.dart';
import 'package:check_bird/screens/task/widgets/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';

class ToDoListMain extends StatelessWidget {
  ToDoListMain({
    Key? key,
    required this.today,
  }) : super(key: key);
  final TodoListController _controller = TodoListController();
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final tomorrow = today.add(const Duration(days: 1));
    final after2day = today.add(const Duration(days: 2));
    final Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: _controller.getTodoList().listenable(),
        builder: (context, Box<Todo> box, _) {
          return SingleChildScrollView(
              child: Column(
                  children: [
                    const ShowDate(text: "Today"),
                    if(_controller.countToDoForDay(today) ==
                        0) const EmptyToDo(),
                    SizedBox(
                      height: size.width * 0.3 *
                          _controller.countToDoForDay(today),
                      child: TodoList(day: today, isToday: true),
                    ),
                    const ShowDate(text: "Tomorrow"),
                    if(_controller.countTaskForDay(tomorrow) ==
                        0) const EmptyToDo(),
                    SizedBox(
                      height: size.width * 0.3 *
                          _controller.countTaskForDay(tomorrow),
                      child: TodoList(day: tomorrow),
                    ),
                    const ShowDate(text: "After Tomorrow"),
                    if(_controller.countTaskForDay(after2day) ==
                        0) const EmptyToDo(),
                    SizedBox(
                      height: size.width * 0.3 *
                          _controller.countTaskForDay(after2day),
                      child: TodoList(day: after2day),
                    ),
                    const ShowDate(text: "More"),
                    SizedBox(
                      height: size.width * 0.3 *
                          _controller.countTaskExcept3Day(today),
                      child: TodoList(day: today, isMore: true),
                    ),

                  ]
              )
          );
        }
    );
  }
}
