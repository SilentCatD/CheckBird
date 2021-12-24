import 'package:check_bird/models/todo/todo_type.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  Todo({
    required this.todoName,
    this.todoDescription,
    required this.type,
    this.color,
    this.deadline,
    this.notification,
    this.weekdays,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  String todoName;
  @HiveField(2)
  String? todoDescription;
  @HiveField(3)
  final TodoType type;
  @HiveField(4)
  int? color;
  @HiveField(5)
  DateTime? deadline; // only if this is task
  @HiveField(6)
  List<bool>? weekdays; // only if this is habit
  @HiveField(7)
  DateTime? lastCompleted; // for habit
  @HiveField(8)
  DateTime? notification; // for notification
  @HiveField(9)
  DateTime? createdDate;
  @HiveField(10)
  DateTime? lastModified;

  int get streak {
    // TODO: based on lastCompleted and weekdays to calculate habits streak
    return 0;
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

  Map<String, dynamic> toJson() {
    // TODO: for save this todo to firebase
    return {
      "id": id,
    };
  }
}
