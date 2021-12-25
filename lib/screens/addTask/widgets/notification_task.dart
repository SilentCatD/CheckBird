import 'package:flutter/material.dart';


class NotificationTask extends StatelessWidget {
  const NotificationTask({
    Key? key,
    required this.onChange,
    required this.items,
    required this.dropdownTask,
  }) : super(key: key);

  final ValueChanged<String?> onChange;
  final String dropdownTask;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Before: ",style: TextStyle(fontSize: 15)),
            DropdownButton(
              value: dropdownTask,
              onChanged: onChange,
              items: items.map((String items) {
                return DropdownMenuItem<String>(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
            )
          ],
        )
    );
  }
}
