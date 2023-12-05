import 'package:check_bird/widgets/week_day_picker/week_day_picker.dart';
import 'package:flutter/material.dart';

enum HabitLoopType {
  everyday,
  weekly,
  custom,
}

class HabitCustom extends StatefulWidget {
  const HabitCustom({super.key, required this.onChanged, this.habitDays});
  final void Function(List<bool> values) onChanged;
  final List<bool>? habitDays;

  @override
  State<HabitCustom> createState() => _HabitCustomState();
}

class _HabitCustomState extends State<HabitCustom> {
  HabitLoopType _habitLoopType = HabitLoopType.everyday;

  @override
  void initState() {
    super.initState();
    if (widget.habitDays != null) _habitLoopType = HabitLoopType.custom;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Everyday'),
          leading: Radio(
            value: HabitLoopType.everyday,
            groupValue: _habitLoopType,
            onChanged: (HabitLoopType? value) {
              setState(() {
                _habitLoopType = value!;
                var values = List.filled(7, true);
                widget.onChanged(values);
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Weekly'),
          leading: Radio(
            value: HabitLoopType.weekly,
            groupValue: _habitLoopType,
            onChanged: (HabitLoopType? value) {
              setState(() {
                _habitLoopType = value!;
                final todayWeekday = DateTime.now().weekday;
                var values = List.filled(7, false);
                values[todayWeekday - 1] = true;
                widget.onChanged(values);
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Custom'),
          leading: Radio(
            value: HabitLoopType.custom,
            groupValue: _habitLoopType,
            onChanged: (HabitLoopType? value) {
              setState(() {
                _habitLoopType = value!;
                var values = List.filled(7, false);
                widget.onChanged(values);
              });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (_habitLoopType == HabitLoopType.custom)
          WeekDayPicker(
            initialValues: widget.habitDays,
            validate: (value) {
              var hasVal = false;
              for (var i = 0; i < value.length; i++) {
                if (value[i]) {
                  hasVal = true;
                  break;
                }
              }
              if (hasVal) return null;
              return "Must pick at least 1 day";
            },
            onChanged: (values) {
              widget.onChanged(values);
            },
          )
      ],
    );
  }
}
