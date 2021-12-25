import 'package:flutter/cupertino.dart';

class DatePicker extends StatelessWidget {
  final ValueChanged<DateTime> onChanged;

  const DatePicker({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        minimumDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
        onDateTimeChanged: onChanged
      ),
    );
  }
}
