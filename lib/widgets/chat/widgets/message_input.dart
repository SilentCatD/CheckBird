import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/widgets//chat/models/message_provider.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({Key? key, required this.chatScreenArguments})
      : super(key: key);
  final ChatScreenArguments chatScreenArguments;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _controller = TextEditingController();

  final _focusNode = FocusNode();
  String _enteredMessages = "";
  final Text _hintTextUnfocused = Text(
    "Aa...",
    style: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 20,
      letterSpacing: 2,
    ),
  );
  final Text _hintTextFocused = Text(
    "Input messages to send...",
    style: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 13,
    ),
  );
  late Text hintText;

  void _sendChat(String text) {
    MessageProvider().sendChat(
      text: text,
      topicId: widget.chatScreenArguments.topicId,
      groupId: widget.chatScreenArguments.groupId,
      chatType: widget.chatScreenArguments.chatType,
    );
  }

  @override
  void initState() {
    super.initState();
    hintText = _hintTextUnfocused;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        hintText = _hintTextFocused;
      } else {
        hintText = _hintTextUnfocused;
      }
      setState(() {});
    });
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
                hintText: hintText.data,
                hintStyle: hintText.style,
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
                contentPadding: const EdgeInsets.all(8),  // Added this
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                onPressed: _enteredMessages.trim().isEmpty ? null :() {
                  _sendChat(_enteredMessages.trim());
                  _focusNode.unfocus();
                  _controller.clear();
                  setState(() {
                    _enteredMessages = "";
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
