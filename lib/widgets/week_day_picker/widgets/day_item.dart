import 'package:flutter/material.dart';

class DayItem extends StatefulWidget {
  const DayItem({
    Key? key,
    required this.text,
    this.selected,
    this.textSelected,
    this.textUnSelected,
    this.unselected,
    required this.index,
    required this.onChangedCaller,
    this.initialValue,
  }) : super(key: key);

  final bool? initialValue;
  final void Function(int index) onChangedCaller;
  final Color? selected;
  final Color? unselected;
  final Color? textSelected;
  final Color? textUnSelected;
  final int index;
  final String text;

  @override
  _DayItemState createState() => _DayItemState();
}

class _DayItemState extends State<DayItem> {
  bool _isSelected = false;

  void _toggleSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    if(widget.initialValue != null) _isSelected = widget.initialValue!;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: _isSelected
              ? (widget.selected ?? Theme.of(context).primaryColor)
              : (widget.unselected ?? Colors.grey.shade300),
        ),
        onPressed: () {
          setState(() {
            _toggleSelected();
            widget.onChangedCaller(widget.index);
          });
        },
        child: Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isSelected
                ? (widget.textSelected ?? Colors.white)
                : (widget.textUnSelected ?? Colors.black54),
          ),
        ));
  }
}
