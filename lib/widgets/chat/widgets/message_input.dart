import 'package:check_bird/models/chat/chat_screen_arguments.dart';
import 'package:check_bird/widgets/chat/models/messages_controller.dart';
import 'package:check_bird/widgets/chat/models/media_type.dart';
import 'package:check_bird/widgets/chat/widgets/preview_image_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  const MessageInput(
      {Key? key,
      required this.chatScreenArguments,
      required this.messagesLogController})
      : super(key: key);
  final ChatScreenArguments chatScreenArguments;
  final ScrollController messagesLogController;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  var _enteredMessages = "";
  final _hintTextUnfocused = Text(
    "Aa...",
    style: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 20,
      letterSpacing: 2,
    ),
  );
  final _hintTextFocused = Text(
    "Input messages to send...",
    style: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 13,
    ),
  );
  var focused = false;

  void _pickImages(ImageSource imageSource) async {
    var picker = ImagePicker();
    XFile? image =
        await picker.pickImage(source: imageSource, imageQuality: 50);
    if (image == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PreviewImageScreen(
          imagePath: image.path,
          groupId: widget.chatScreenArguments.groupId,
          topicId: widget.chatScreenArguments.topicId,
          chatType: widget.chatScreenArguments.chatType,
        ),
      ),
    );
  }

  void _sendChat(String text) async {
    await MessagesController().sendChat(
      mediaType: MediaType.text,
      data: text,
      topicId: widget.chatScreenArguments.topicId,
      groupId: widget.chatScreenArguments.groupId,
      chatType: widget.chatScreenArguments.chatType,
    );
    await widget.messagesLogController.animateTo(
      widget.messagesLogController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          focused = true;
        } else {
          focused = false;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                focusNode: _focusNode,
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (text) {
                  setState(() {
                    _enteredMessages = text;
                  });
                },
                decoration: InputDecoration(
                  hintText:
                      focused ? _hintTextFocused.data : _hintTextUnfocused.data,
                  hintStyle: focused
                      ? _hintTextFocused.style
                      : _hintTextUnfocused.style,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(8), // Added this
                ),
              ),
            ),
          ),
          if (!focused)
            IconButton(
              onPressed: () {
                _pickImages(ImageSource.camera);
              },
              icon: const Icon(Icons.camera_alt_rounded),
              color: Colors.white,
            ),
          if (!focused)
            IconButton(
              onPressed: () {
                _pickImages(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
              color: Colors.white,
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            onPressed: focused
                ? _enteredMessages.trim().isEmpty
                    ? null
                    : () {
                        _sendChat(_enteredMessages.trim());
                        _focusNode.unfocus();
                        _controller.clear();
                        setState(() {
                          _enteredMessages = "";
                        });
                      }
                : () {
                    _sendChat('\u{2705}');
                    _focusNode.unfocus();
                    _controller.clear();
                    setState(() {
                      _enteredMessages = "";
                    });
                  },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: focused
                  ? const Icon(
                      Icons.send,
                    )
                  : const Icon(
                      Icons.check_box,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
