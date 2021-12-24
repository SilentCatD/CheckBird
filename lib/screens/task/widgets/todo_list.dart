import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/screens/task/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';

class TodoList extends StatelessWidget {
  TodoList({Key? key}) : super(key: key);
  final TodoListController _controller = TodoListController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller.getTodoList().listenable(),
      builder: (context, Box<Todo> box, _) {
        final todos = box.values.toList();
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return TodoItem(todo: todos[index]);
          },
        );
      },
    );
  }
}
