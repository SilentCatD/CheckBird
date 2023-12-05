import 'package:check_bird/widgets/date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

enum Notification {
  none, // not set notification
  att, // at that time
  db1, // 1 day before
  db2, // 2 day before
  db3, // 3 day before
}

class TaskCustom extends StatefulWidget {
  const TaskCustom(
      {Key? key,
      required this.initialDate,
      required this.onChangedDue,
      required this.onChangedNotification})
      : super(key: key);
  final DateTime? initialDate;
  final void Function(String value) onChangedDue;
  final void Function(DateTime? dateTime) onChangedNotification;

  @override
  State<TaskCustom> createState() => _TaskCustomState();
}

class _TaskCustomState extends State<TaskCustom> {
  static final Map<Notification, String> _notificationType = {
    Notification.none: "Don't remind me",
    Notification.att: "At the time",
    Notification.db1: "1 Day before",
    Notification.db2: "2 Day before",
    Notification.db3: "3 Day before",
  };

  DateTime _pickedDay = DateTime.now().add(const Duration(minutes: 5));
  Notification _pickedNotificationType = Notification.none;

  @override
  Widget build(BuildContext context) {
    if (widget.initialDate != null) _pickedDay = widget.initialDate!;
    return Column(
      children: [
        const ListTile(
          title: Text(
            "Due date",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DateTimePicker(
          initialValue: widget.initialDate == null
              ? _pickedDay.toString()
              : widget.initialDate.toString(),
          type: DateTimePickerType.dateTimeSeparate,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 5),
          onChanged: (value) {
            setState(() {
              _pickedDay = DateTime.parse(value);
              _pickedNotificationType = Notification.none;
            });
            widget.onChangedDue(value);
          },
          validator: (value) {
            final pickedValue = DateTime.parse(value!);
            if (pickedValue.isBefore(DateTime.now())) {
              return "Can't schedule a task in the past!";
            }
            return null;
          },
          onSaved: (value) {
            widget.onChangedDue(value!);
          },
        ),
        const ListTile(
          title: Text(
            "Notification",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DropdownButton<Notification>(
          value: _pickedNotificationType,
          items: [
            // add function to generate more of this if you like
            DropdownMenuItem(
              value: Notification.none,
              child: Text(_notificationType[Notification.none]!),
            ),
            DropdownMenuItem(
              value: Notification.att,
              child: Text(_notificationType[Notification.att]!),
            ),
            if (daysBetween(DateTime.now(), _pickedDay) >= 1)
              DropdownMenuItem(
                value: Notification.db1,
                child: Text(_notificationType[Notification.db1]!),
              ),
            if (daysBetween(DateTime.now(), _pickedDay) >= 2)
              DropdownMenuItem(
                value: Notification.db2,
                child: Text(_notificationType[Notification.db2]!),
              ),
            if (daysBetween(DateTime.now(), _pickedDay) >= 3)
              DropdownMenuItem(
                value: Notification.db3,
                child: Text(_notificationType[Notification.db3]!),
              ),
          ],
          onChanged: (value) {
            setState(() {
              _pickedNotificationType = value!;
            });
            Duration? daysDuration;
            if (value == Notification.att) {
              daysDuration = const Duration();
            } else if (value == Notification.db1) {
              daysDuration = const Duration(days: 1);
            } else if (value == Notification.db2) {
              daysDuration = const Duration(days: 2);
            } else if (value == Notification.db3) {
              daysDuration = const Duration(days: 3);
            }
            if (daysDuration == null) {
              widget.onChangedNotification(null);
            } else {
              widget.onChangedNotification(_pickedDay.subtract(daysDuration));
            }
          },
        )
      ],
    );
  }
}
