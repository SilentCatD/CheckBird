import 'package:check_bird/models/todo/todo_type.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:check_bird/services/notification.dart';
import 'todo_type.dart';
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


      todo.notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

      String title = "CheckBird Notification";
      String body = "Deadline: "+ todo.todoName + DateFormat('yyyy-MM-dd – kk:mm').format(todo.deadline!);

      await NotificationService().createScheduleNotification(
          todo.notificationId!, title, body, todo.notification!, false);
    }


/*    if(todo.type == TodoType.task) {
      String title = "Notification CheckBird";
      String body = "Deadline: " + todo.deadline.toString();
      await NotificationService().createScheduleNotification(
          todo.notificationId!, title, body, now.add(Duration(seconds: 5)), false);
    }*/
  }

  List<Todo> getAllHabit() {
    List<Todo> todolist = [];
    for (int i = 0; i < getTodoList().length; i++) {
      if (getTodoList().values.toList()[i].getType() == TodoType.habit) {
        todolist.add(getTodoList().values.toList()[i]);
      }
    }
    return todolist;
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

  List<Todo> getHabitForMultiDays(List<bool> days){
    List<Todo> todolist = getAllHabit();
    for(int i = 0; i < todolist.length; i++){
      bool check = true;
      for(int j = 0; j < days.length;j++){
        if(days[j] == true && todolist[i].getNewWeekdays()[j] == days[j]){
          check = false;
          break;
        }
      }
      if(check){
        todolist.removeAt(i);
        i--;
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

  int countToDoForDay(DateTime day){
    List<Todo> todoList = getToDoForDay(day);
    return todoList.length;
  }

  int countTaskForDay(DateTime day){
    List<Todo> todoList = getTaskForDay(day);
    return todoList.length;
  }

  List<Todo> getTaskExcept3Day(DateTime day) {
    List<Todo> todolist = [];
    DateTime after3day = day.add(const Duration(days: 3));
    for (int i = 0; i < getTodoList().length; i++) {
      if (getTodoList().values.toList()[i].getType() == TodoType.task &&
          getTodoList().values.toList()[i].getDueTime().compareTo(after3day) == 1) {
        todolist.add(getTodoList().values.toList()[i]);
      }
    }
    return todolist;
  }

  int countTaskExcept3Day(DateTime day){
    List<Todo> todoList = getTaskExcept3Day(day);
    return todoList.length;
  }




  void removeAllTodo() {
    var todoList = getTodoList();
    todoList.clear();
  }

}
