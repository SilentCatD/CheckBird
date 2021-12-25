import 'package:flutter/material.dart';

class TodoNameInput extends StatelessWidget {
  const TodoNameInput({Key? key, required this.onSaved}) : super(key: key);
  final void Function(String value) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey("todo-name"),
      maxLines: 1,
      maxLength: 50,
      decoration: const InputDecoration(
        hintStyle: TextStyle(letterSpacing: 2),
        hintText: "Todo name...",
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        onSaved(value!);
      },
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Todo name must not be empty";
        } else if (value.trim().length < 4) {
          return "Todo name must be at least 4 characters";
        }
        // add more conditions here if needed
        else {
          return null;
        }
      },
    );
  }
}
