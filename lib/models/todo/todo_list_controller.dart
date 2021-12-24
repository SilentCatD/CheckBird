import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'todo.dart';

class TodoListController {
  Future<void> openBox() async {
    await Hive.openBox<Todo>('todos');
  }

  Future<void> syncTodo() async {
    // TODO: last modified field of each todo may help
  }

  Future<void> closeBox() async {
    await Hive.box('todos').close();
  }

  Box<Todo> getTodoList() {
    // use ValueListenableBuilder to listen to this
    return Hive.box<Todo>('todos');
  }

  void todoCompleted(Todo todo) {
    DateTime now = DateTime.now();
    todo.lastCompleted = now;
    todo.lastModified = now;
    todo.save();
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

  void removeTodo(Todo todo) {
    todo.delete();
  }

  void editTodo(Todo oldTodo, Todo newTodo) {
    // only these field are editable
    oldTodo.todoName = newTodo.todoName;
    oldTodo.notification = newTodo.notification;
    oldTodo.deadline = newTodo.deadline;
    oldTodo.color = newTodo.color;
    oldTodo.todoDescription = newTodo.todoDescription;
    oldTodo.weekdays = newTodo.weekdays;
    oldTodo.lastCompleted = DateTime.now();
    oldTodo.save();
  }
}
