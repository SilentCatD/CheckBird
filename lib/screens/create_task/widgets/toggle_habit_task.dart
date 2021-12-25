import 'package:check_bird/models/todo/todo_type.dart';
import 'package:flutter/material.dart';

class ToggleHabitTask extends StatelessWidget {
  const ToggleHabitTask(
      {Key? key, required this.todoType, required this.onChanged})
      : super(key: key);
  final void Function(bool value) onChanged;
  final TodoType todoType;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      title:
          todoType == TodoType.task ? const Text("Task") : const Text("Habit"),
      subtitle: todoType == TodoType.task
          ? const Text("Create task")
          : const Text("Create habit"),
      secondary: todoType == TodoType.task
          ? const Icon(Icons.task)
          : const Icon(Icons.loop),
      value: todoType == TodoType.habit,
      onChanged: onChanged,
    );
  }
}
