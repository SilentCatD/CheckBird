import 'package:check_bird/widgets/chat/models/media_type.dart';
import 'package:check_bird/widgets/chat/widgets/image_view_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.photoUrl,
    required this.isMe,
    required this.senderName,
    required this.sendAt,
    required this.mediaType,
  });

  final MediaType mediaType;
  final Timestamp sendAt;
  final String senderName;
  final String message;
  final bool isMe;
  final String photoUrl;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool showTime = false;

  String get _sendAtString {
    final sendTime = widget.sendAt.toDate();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final sendDate = DateTime(sendTime.year, sendTime.month, sendTime.day);
    DateFormat sendTimeFormat = DateFormat.Hm();
    if (today == sendDate) {
      return sendTimeFormat.format(sendTime);
    }
    return sendTimeFormat.add_yMMMd().format(sendTime);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: [
            if (showTime)
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Text(
                  _sendAtString,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            Row(
              mainAxisAlignment:
                  widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!widget.isMe)
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.photoUrl),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: widget.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (!widget.isMe)
                        Text(
                          widget.senderName,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 13),
                        ),
                      if (widget.mediaType == MediaType.text)
                        TextMedia(
                          constraints: constraint,
                          text: widget.message,
                          onPress: () {
                            setState(() {
                              showTime = !showTime;
                            });
                          },
                          isMe: widget.isMe,
                          showTime: showTime,
                        )
                      else if (widget.mediaType == MediaType.image)
                        ImageMedia(
                          isMe: widget.isMe,
                          onPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageViewChatScreen(
                                  imageUrl: widget.message,
                                ),
                              ),
                            );
                          },
                          constraints: constraint,
                          imageUrl: widget.message,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ImageMedia extends StatelessWidget {
  const ImageMedia(
      {super.key,
      required this.isMe,
      required this.onPress,
      required this.constraints,
      required this.imageUrl});
  final String imageUrl;
  final bool isMe;
  final Function() onPress;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        constraints: BoxConstraints(
            maxWidth:
                isMe ? constraints.maxWidth * 0.8 : constraints.maxWidth * 0.7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class TextMedia extends StatelessWidget {
  const TextMedia(
      {super.key,
      required this.constraints,
      required this.text,
      required this.onPress,
      required this.isMe,
      required this.showTime});
  final BoxConstraints constraints;
  final String text;
  final Function() onPress;
  final bool isMe;
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: isMe
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondaryContainer,
        child: InkWell(
          onTap: onPress,
          borderRadius: BorderRadius.circular(15),
          child: Container(
              constraints: BoxConstraints(
                  maxWidth: isMe
                      ? constraints.maxWidth * 0.7
                      : constraints.maxWidth * 0.6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                text,
                softWrap: true,
                style: TextStyle(
                  color: isMe ? Colors.white : null,
                  fontSize: 16,
                ),
              )),
        ),
      ),
    );
  }
}
