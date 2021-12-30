import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_type.dart';
import 'package:check_bird/screens/create_task/create_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key, required this.todo, this.isCheck = true})
      : super(key: key);
  final Todo todo;
  final bool isCheck;

  String get habitDays {
    final days = todo.weekdays;
    String result = '';
    for (var i = 0; i < days!.length; i++) {
      if (days[i]) {
        if (i == 6) {
          result += 'sun-';
        } else {
          result += '${i + 2}-';
        }
      }
    }
    result = result.substring(0, result.length - 1);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Opacity(
      opacity: todo.isCompleted ? 0.3 : 1,
      child: Align(
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
                    color: Color(todo.backgroundColor),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateTodoScreen(todo: todo,)));
                      },
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
                                          ? habitDays
                                          : DateFormat.Hm()
                                              .format(todo.deadline!),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  todo.todoName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(todo.textColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (isCheck)
              Expanded(
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
      ),
    );
  }
}
