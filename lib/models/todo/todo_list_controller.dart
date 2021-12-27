import 'package:check_bird/models/todo/todo_type.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:check_bird/services/notification.dart';
import 'todo_type.dart';
import 'todo.dart';


extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

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

    if(todo.type == TodoType.task) {
      String title = "Notification CheckBird";
      String body = "Deadline: " + todo.deadline.toString();
      await NotificationService().createScheduleNotification(
          todo.id.hashCode, title, body,
          DateTime.now().add(Duration(seconds: 5)), false);
    }

  }

  List<Todo> getHabitForWeekDays(int select) {
    List<Todo> todolist = [];
    for (int i = 0; i < getTodoList().length; i++) {
      if (getTodoList().values.toList()[i].getType() == TodoType.habit) {
        if (getTodoList().values.toList()[i].getNewWeekdays()[select] == true) {
          todolist.add(getTodoList().values.toList()[i]);
        }
      }
    }
    return todolist;
  }

  List<Todo> getTaskForDay(DateTime day) {
    List<Todo> todolist = [];

    for (int i = 0; i < getTodoList().length; i++) {
      if(getTodoList().values.toList()[i].getType() == TodoType.task){
        if (getTodoList().values.toList()[i].getDueTime().isSameDate(day)) {
          todolist.add(getTodoList().values.toList()[i]);
        }
      }
    }
    return todolist;
  }

  List<Todo> getToDoForDay(DateTime day) {
    List<Todo> todolist = [];
    todolist = getTaskForDay(day);
    List<Todo> temp = getHabitForWeekDays(day.weekday - 1);
    for(int i = 0; i < temp.length;i++){
      todolist.add(temp[i]);
    }

    return todolist;
  }





  void removeAllTodo() {
    var todoList = getTodoList();
    todoList.clear();
  }

}
