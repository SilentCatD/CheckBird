import 'package:hive/hive.dart';
part 'todo_type.g.dart';

@HiveType(typeId: 1)
enum TodoType{
  @HiveField(0)
  task,
  @HiveField(1)
  habit,
}