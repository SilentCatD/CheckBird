import 'package:flutter/material.dart';

class TodoDescriptionInput extends StatelessWidget {
  const TodoDescriptionInput(
      {super.key, required this.onSaved, required this.todoDescription});
  final void Function(String value) onSaved;
  final String todoDescription;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey("todo-description"),
      initialValue: todoDescription,
      expands: true,
      maxLines: null,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      decoration: const InputDecoration(
        hintText: "Todo description...",
        hintStyle: TextStyle(letterSpacing: 1),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        onSaved(value!);
      },
    );
  }
}
