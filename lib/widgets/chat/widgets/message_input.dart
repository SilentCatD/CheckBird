import 'package:check_bird/models/chat_screen_arguments.dart';
import 'package:check_bird/widgets//chat/models/message_provider.dart';
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

  void _sendChat(String text) async {
    await MessageProvider().sendChat(
      text: text,
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
          Flexible(
            flex: 2,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                onPressed: _enteredMessages.trim().isEmpty
                    ? null
                    : () {
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
