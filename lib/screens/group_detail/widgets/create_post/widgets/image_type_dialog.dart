import 'package:flutter/material.dart';

class ImageTypeDialog extends StatelessWidget {
  const ImageTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Where to pick image?"),
      content: const Text("Do you want to take a picture or choose one from your device?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, child: const Text("Take a picture")),
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, child: const Text("Load from device")),
      ],
    );
  }
}
