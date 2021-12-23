import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget{
  final String text;

  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )
        // padding: const EdgeInsets.only(left: 5),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 30),
      ),
      onPressed: onClicked,
    );
  }
}