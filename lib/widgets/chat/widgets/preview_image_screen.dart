import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PreviewImageScreen extends StatelessWidget {
  const PreviewImageScreen({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    File image = File(imagePath);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.file(image).image,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(margin: const EdgeInsets.only(bottom: 20), child: ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Icon(Icons.cancel))),
            Container(margin: const EdgeInsets.only(bottom: 20) ,child: ElevatedButton(onPressed: (){
              // TODO
              // send image to FireStore and return url string
            }, child: const Icon(Icons.check))),
          ],
        ),
      ),
    );
  }
}
