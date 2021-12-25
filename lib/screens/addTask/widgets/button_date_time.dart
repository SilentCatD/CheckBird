import 'package:check_bird/screens/addTask/widgets/widgets%20common/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ButtonDateTime extends StatelessWidget {
  final String text;
  final ValueChanged<DateTime> onChanged;
  final DateTime dueTime;
  final bool isNull;
  final void Function() onSheet;

  const ButtonDateTime({
    Key? key,
    required this.dueTime,
    required this.isNull,
    required this.text,
    required this.onChanged,
    required this.onSheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text + ": ",style: const TextStyle(fontSize: 15)),
            ElevatedButton(
                child: (isNull) ? const Text("Click me") : Text(
                  DateFormat("dd/MM/yyyy hh:mm aaa").format(dueTime),
                  style: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        actions:[
                          DateTimePicker(onChanged: onChanged),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text("Done"),
                          onPressed: (){
                            onSheet;
                            Navigator.pop(context);
                          },
                        ),
                      )
                  );
                }
            ),
          ],
        )

    );
  }
}
