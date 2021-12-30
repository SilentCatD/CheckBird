import 'package:check_bird/widgets/week_day_picker/widgets/day_item.dart';
import 'package:flutter/material.dart';

class WeekDayPicker extends StatefulWidget {
  const WeekDayPicker({
    Key? key,
    this.initialValues,
    this.unselected,
    this.selected,
    this.textUnSelected,
    this.textSelected,
    this.backgroundColor = Colors.transparent,
    this.onChanged,
    this.validate,
    this.forcedOneDayOnly,
  }) : super(key: key);
  final bool? forcedOneDayOnly; //  forces one day only, should be used with at least 1 `true` in initialValues
  final List<bool>? initialValues; // set initial value of the List<bool>
  final Color? selected;
  final Color? unselected;
  final Color? textSelected;
  final Color? textUnSelected;
  final Color? backgroundColor;
  final String? Function(List<bool> values)? validate;

  final void Function(List<bool> chosenDays)? onChanged; // onChanged call back, fired when changed

  @override
  State<WeekDayPicker> createState() => _WeekDayPickerState();
}

class _WeekDayPickerState extends State<WeekDayPicker> {
  final listOfDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  var onChangedReturn = [false, false, false, false, false, false, false];
  late List<DayItem> days;
  String? errorText;

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) onChangedReturn = widget.initialValues!;
  }

  void onChangedCaller(index) {
    setState(() {
      if (widget.forcedOneDayOnly != null && widget.forcedOneDayOnly == true) {
        for (var i = 0; i < onChangedReturn.length; i++) {
          onChangedReturn[i] = false;
        }
      }
      onChangedReturn[index] = !onChangedReturn[index];
      if (widget.onChanged != null) {
        widget.onChanged!(onChangedReturn);
      }
      if (widget.validate != null) {
        errorText = widget.validate!(onChangedReturn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: widget.backgroundColor,
          height: size.height * 0.05,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < listOfDays.length; i++)
                  DayItem(
                    value: onChangedReturn[i],
                    selected: widget.selected,
                    unselected: widget.unselected,
                    textSelected: widget.textSelected,
                    textUnSelected: widget.textSelected,
                    text: listOfDays[i],
                    index: i,
                    onChangedCaller: onChangedCaller,
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          errorText ?? "",
          style: TextStyle(color: Theme.of(context).errorColor),
        )
      ],
    );
  }
}
