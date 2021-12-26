import 'package:flutter/material.dart';

class DayItem extends StatefulWidget {
  DayItem({
    Key? key,
    required this.text,
    this.selected,
    this.textSelected,
    this.textUnSelected,
    this.unselected,
    required this.index,
    required this.onChangedCaller,
  }) : super(key: key);

  final void Function(int index) onChangedCaller;
  late Color? selected;
  late Color? unselected;
  late Color? textSelected;
  late Color? textUnSelected;
  final int index;
  final String text;

  @override
  _DayItemState createState() => _DayItemState();
}

class _DayItemState extends State<DayItem> {
  bool _isSelected = false;
  bool _isInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitData == false) {
      widget.selected ??= Theme.of(context).primaryColor;
      widget.unselected ??= Colors.grey.shade300;
      widget.textSelected ??= Colors.white;
      widget.textUnSelected ??= Colors.black54;
      _isInitData = true;
    }
  }

  void _toggleSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: _isSelected ? widget.selected : widget.unselected,
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
            color: _isSelected ? widget.textSelected : widget.textUnSelected,
          ),
        ));
  }
}
