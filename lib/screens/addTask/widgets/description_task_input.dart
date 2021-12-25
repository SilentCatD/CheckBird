import 'package:flutter/material.dart';


class DescriptionTaskInput extends StatelessWidget {
  const DescriptionTaskInput({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  final ValueChanged<String?> onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      decoration: const InputDecoration(
        labelText: 'Description',
        border:  OutlineInputBorder(),
      ),
      onSaved: onChange,
    );
  }
}
