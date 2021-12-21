import 'package:check_bird/models/chat_type.dart';
import 'package:check_bird/widgets/chat/models/message_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PreviewImageScreen extends StatelessWidget {
  const PreviewImageScreen(
      {Key? key,
      required this.imagePath,
      required this.chatType,
      required this.groupId,
      required this.topicId})
      : super(key: key);
  final String imagePath;
  final String groupId;
  final String? topicId;
  final ChatType chatType;

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
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.cancel))),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  MessageProvider().sendImg(
                      image: image,
                      chatType: chatType,
                      groupId: groupId,
                      topicId: topicId);
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.check),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
