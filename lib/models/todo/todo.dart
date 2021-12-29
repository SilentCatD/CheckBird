import 'package:check_bird/models/todo/todo_type.dart';
import 'package:hive/hive.dart';
import 'package:check_bird/services/notification.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  // you can use this if you want
  Todo({
    required this.todoName,
    required this.todoDescription,
    required this.type,
    required this.backgroundColor,
    this.deadline,
    this.notification,
    this.weekdays,
    this.groupId,
    this.notificationId,
    required this.textColor,
  });

  // or use this to avoid confusion
  Todo.task({
    required this.todoName,
    required this.todoDescription,
    this.deadline,
    this.notification,
    this.groupId,
    required this.textColor,
    required this.backgroundColor,
  }) {
    type = TodoType.task;
  }

  Todo.habit(
      {required this.todoName,
      required this.todoDescription,
      required this.textColor,
      required this.backgroundColor,
      this.weekdays,
      this.groupId}) {
    type = TodoType.habit;
  }

  @HiveField(0)
  String? id;
  @HiveField(1)
  String todoName;
  @HiveField(2)
  String todoDescription;
  @HiveField(3)
  late final TodoType type;
  @HiveField(4)
  int backgroundColor;
  @HiveField(5)
  int textColor;
  @HiveField(6)
  DateTime? deadline; // only if this is task
  @HiveField(7)
  List<bool>? weekdays; // only if this is habit
  @HiveField(8)
  DateTime? lastCompleted; // for habit
  @HiveField(9)
  DateTime? notification; // for notification
  @HiveField(10)
  int? notificationId;
  @HiveField(11)
  DateTime? createdDate;
  @HiveField(12)
  DateTime? lastModified;
  @HiveField(13)
  String? groupId; // null if this to-do not belong to any group

  int get streak {
    // TODO: based on lastCompleted and weekdays to calculate habits streak
    return 0;
  }

  void deleteTodo() {
    delete();
  }

  DateTime getDueTime(){
    return deadline!;
  }

  List<bool> getNewWeekdays(){
    return weekdays!;
  }
  TodoType getType(){
    return type;
  }

  DateTime getLastCompleted(){
    return lastCompleted!;
  }



  void toggleCompleted() {
    DateTime now = DateTime.now();
    if (lastCompleted == null) {
      lastCompleted = now;
    } else {
      lastCompleted = null;
    }
    lastModified = now;
    save();
  }

  Future<void>  toggleCancelNotification() async {
    await NotificationService().cancelScheduledNotifications(this.notificationId!);
  }


  void editTodo({
    String? newName,
    String? newDescription,
    int? newBackgroundColor,
    int? newTextColor,
    DateTime? newNotification,
    DateTime? newDeadline,
    List<bool>? newWeekdays,
  }) {
    // remember to check if anything changed before call this function, if not dont call it
    // only these field are editable
    todoName = newName ?? todoName;
    todoDescription = (newDescription) ?? todoDescription;
    backgroundColor = newBackgroundColor ?? backgroundColor;
    textColor = newTextColor ?? textColor;
    deadline = newDeadline ?? deadline;
    weekdays = newWeekdays ?? weekdays;


    if(newNotification!= notification){
    //  TODO: reschedule here
    //   notification ?
    //   notificationId ?
    }

    save();
  }

  bool get isCompleted {
    if (lastCompleted != null) {
      DateTime now = DateTime.now();
      return now.year == lastCompleted!.year &&
          now.month == lastCompleted!.month &&
          now.day == lastCompleted!.day;
    }
    return false;
  }

  Future<void> syncData() async {
    // TODO: sync this to firebase, last modified may help
    // Check if this need sync or not ? if yes sync TO database or sync FROM database
    // Sync accordingly
  }

  Map<String, dynamic> toJson() {
    // TODO: for save this todo to firebase
    return {
      "id": id,
    };
  }
}
