import 'package:flutter/material.dart';

class RemoveAllItemAD extends StatelessWidget {
  const RemoveAllItemAD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure?"),
      content: const Text("You're about to delete all todos?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("No")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Yes")),
      ],
    );
  }
}
