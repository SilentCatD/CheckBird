import 'package:flutter/material.dart';

class ImageViewChatScreen extends StatelessWidget {
  const ImageViewChatScreen({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0x44000000),
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          width: size.width,
          child: Image.network(imageUrl, fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
