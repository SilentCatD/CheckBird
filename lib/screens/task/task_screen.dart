import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/models/todo/todo_type.dart';
import 'package:check_bird/screens/task/widgets/todo_list.dart';
import 'package:check_bird/widgets/focus/focus_widget.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  static const routeName = '/task-screen';

  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Task"),
        actions: const [
          FocusButton(),
        ],
      ),
      body: TodoList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // This is fake add
          TodoListController().removeAllTodo();
          //int year, [int month = 1,int day = 1,int hour = 0,int minute = 0,int second = 0,int millisecond = 0,int microsecond = 0,]
          // DateTime deadline = DateTime(2021, 12, 30, 15, 21);
          // TodoListController().addTodo(Todo(
          //   todoName: "Task",
          //   type: TodoType.task,
          //   deadline: deadline,
          // ));
          // TodoListController().addTodo(Todo(todoName: "Habit", type: TodoType.habit));
        },
      ),
    );
  }
}
