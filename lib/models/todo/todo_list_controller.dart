import 'package:check_bird/models/todo/todo_type.dart';
import 'package:check_bird/services/notifactions.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'todo.dart';

class TodoListController {
  Future<void> openBox() async {
    await Hive.openBox<Todo>('todos');
  }

  Future<void> syncTodoList() async {
    // TODO: sync all todo to firebase using their own `sync` function
  }

  Future<void> closeBox() async {
    await Hive.box('todos').close();
  }

  Box<Todo> getTodoList() {
    // use ValueListenableBuilder to listen to this
    return Hive.box<Todo>('todos');
  }

  Future<void> addTodo(Todo todo)  async{
    var todoList = getTodoList();
    String id = const Uuid().v1();
    DateTime now = DateTime.now();
    // hive key and to-do id is the same
    todo.id = id;
    todo.createdDate = now;
    todo.lastModified = now;
    todoList.add(todo);

    if(todo.type == TodoType.task && todo.notification != null) {
      String title = "Notification CheckBird";
      String body = "Deadline: " + todo.deadline.toString();
      await NotificationService().createScheduleNotification(
          todo.id.hashCode, title, body, todo.notification!, false);
    }
  }

  void removeAllTodo() {
    var todoList = getTodoList();
    todoList.clear();
  }

}
