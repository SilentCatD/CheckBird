import 'package:flutter/material.dart';

class RepeatHabit extends StatelessWidget{
  const RepeatHabit({
    Key? key,
    required this.onChange,
    required this.items,
    required this.dropdownValue,
  }) : super(key: key);

  final ValueChanged<String?> onChange;
  final String dropdownValue;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Repeat: ",style: TextStyle(fontSize: 15)),
            DropdownButton(
              value: dropdownValue,
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

