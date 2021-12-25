import 'package:check_bird/screens/test/widgets/week_day_picker/widgets/day_item.dart';
import 'package:flutter/material.dart';

class WeekDayPicker extends StatefulWidget {
  WeekDayPicker({
    Key? key,
    this.unselected,
    this.selected,
    this.textUnSelected,
    this.textSelected,
    this.backgroundColor,
    this.onChanged,
  }) : super(key: key);

  late Color? selected;
  late Color? unselected;
  late Color? textSelected;
  late Color? textUnSelected;
  late Color? backgroundColor;

  final void Function(List<bool> chosenDays)? onChanged;

  @override
  State<WeekDayPicker> createState() => _WeekDayPickerState();
}

class _WeekDayPickerState extends State<WeekDayPicker> {
  final listOfDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  final onChangedReturn = [false, false, false, false, false, false, false];
  late List<DayItem> days;

  @override
  void initState() {
    super.initState();
    widget.backgroundColor ??= Colors.transparent;
    var dayHolder = <DayItem>[];
    for (var i = 0; i < listOfDays.length; i++) {
      dayHolder.add(DayItem(
        text: listOfDays[i],
        index: i,
        onChangedCaller: onChangedCaller,
      ));
    }
    days = dayHolder;
  }

  void onChangedCaller(index) {
    onChangedReturn[index] = !onChangedReturn[index];
    if (widget.onChanged != null);
    widget.onChanged!(onChangedReturn);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: widget.backgroundColor,
      height: size.height * 0.05,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: days,
        ),
      ),
    );
  }
}
