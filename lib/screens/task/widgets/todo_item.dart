import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key, required this.todo, this.isCheck = true}) : super(key: key);
  final Todo todo;
  final bool isCheck;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.7,
            height: 100,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            color: todo.type == TodoType.habit
                                ? Colors.greenAccent
                                : Colors.amber,
                            width: constraints.maxWidth * 0.4,
                            height: constraints.maxHeight * 0.3,
                            child: Center(
                                child: Text(
                              todo.type == TodoType.habit ? "Habit" : "Task",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            )),
                          ),
                          Expanded(
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              height: constraints.maxHeight * 0.3,
                              child: Center(
                                child: Text(
                                  todo.type == TodoType.habit
                                      ? 'Streak ${todo.streak}'
                                      : DateFormat.Hm().format(todo.deadline!),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Center(child: Text(todo.todoName))),
                    ],
                  ),
                );
              },
            ),
          ),
          if(isCheck) Expanded(
            child: Center(
              child: Transform.scale(
                scale: 2,
                child: Checkbox(
                  value: todo.isCompleted,
                  shape: const CircleBorder(),
                  onChanged: (_) {
                    todo.toggleCompleted();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
