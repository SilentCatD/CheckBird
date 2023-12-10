import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  const DayItem({
    super.key,
    required this.text,
    this.selected,
    this.textSelected,
    this.textUnSelected,
    this.unselected,
    required this.index,
    required this.onChangedCaller,
    required this.value,
  });

  final void Function(int index) onChangedCaller;
  final Color? selected;
  final Color? unselected;
  final Color? textSelected;
  final Color? textUnSelected;
  final int index;
  final String text;
  final bool value;

//   @override
//   _DayItemState createState() => _DayItemState();
// }
//
// class _DayItemState extends State<DayItem> {
//   bool _isSelected = true;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: value
              ? (selected ?? Theme.of(context).colorScheme.primary)
              : (unselected ??
                  Theme.of(context).colorScheme.secondaryContainer),
        ),
        onPressed: () {
          onChangedCaller(index);
        },
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: value
                ? (textSelected ?? Colors.white)
                : (textUnSelected ?? Colors.black54),
          ),
        ));
  }
}
