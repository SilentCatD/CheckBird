import 'package:flutter/cupertino.dart';

class DateTimePicker extends StatelessWidget {
  final ValueChanged<DateTime> onChanged;

  const DateTimePicker({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        mode: CupertinoDatePickerMode.dateAndTime,
        minimumDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,DateTime.now().hour,DateTime.now().minute),
        onDateTimeChanged: onChanged
      ),
    );
  }
}
