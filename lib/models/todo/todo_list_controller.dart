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

  void addTodo(Todo todo) {
    var todoList = getTodoList();
    String id = const Uuid().v1();
    DateTime now = DateTime.now();
    // hive key and to-do id is the same
    todo.id = id;
    todo.createdDate = now;
    todo.lastModified = now;
    todoList.add(todo);
  }

  void removeAllTodo() {
    var todoList = getTodoList();
    todoList.clear();
  }

}
