import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/screens/task/widgets/todo_item.dart';
import 'package:flutter/material.dart';

class ToDoItemRemove extends StatelessWidget {
  const ToDoItemRemove({super.key, required this.todos,required this.index, this.isCheck = true});

  final List<Todo> todos;
  final int index;
  final bool isCheck;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
                  "You're about to delete?"),
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
      child: TodoItem(todo: todos[index], isCheck: isCheck),
    );
  }
}
