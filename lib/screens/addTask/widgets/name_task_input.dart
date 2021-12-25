import 'package:flutter/material.dart';

class NameTaskInput extends StatelessWidget {
  const NameTaskInput({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  final ValueChanged<String?> onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      decoration: const InputDecoration(
        labelText: "Name Task",
        border:  OutlineInputBorder(),
      ),
      validator: (value) {
        if (value.toString().isEmpty) {
          return "Name task is required!";
        }
        return null;
      },
      onSaved: onChange,
    );
  }
}
