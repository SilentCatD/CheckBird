import 'package:flutter/material.dart';


class TitleSwitch extends StatelessWidget {
  const TitleSwitch({
    Key? key,
    required this.text,
    required this.isTrue,
    required this.onChange,
    required this.icon,
  }) : super(key: key);

  final String text;
  final ValueChanged<bool> onChange;
  final bool isTrue;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child:SwitchListTile(
          title: Text(text),
          value: isTrue,
          onChanged: onChange,
          secondary: icon,
        )
    );
  }
}
