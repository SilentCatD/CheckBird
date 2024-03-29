import 'package:check_bird/models/chat/chat_screen_arguments.dart';
import 'package:check_bird/widgets/chat/models/messages_controller.dart';
import 'package:check_bird/widgets/chat/models/media_type.dart';
import 'package:check_bird/widgets/chat/widgets/preview_image_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MessageInput extends StatefulWidget {
  const MessageInput(
      {super.key,
      required this.chatScreenArguments,
      required this.messagesLogController});
  final ChatScreenArguments chatScreenArguments;
  final ScrollController messagesLogController;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  var _enteredMessages = "";
  final _hintTextUnfocused = const Text(
    "Aa...",
    style: TextStyle(
      fontSize: 20,
      letterSpacing: 2,
    ),
  );
  final _hintTextFocused = const Text(
    "Input messages to send...",
    style: TextStyle(
      fontSize: 13,
    ),
  );
  var focused = false;

  Future<File?> _cropImage(File image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ]);
    if (croppedFile != null) {
      image = File(croppedFile.path);
      return image;
    }
    return null;
  }

  void _pickImages(ImageSource imageSource) async {
    var picker = ImagePicker();
    XFile? pickedImage =
        await picker.pickImage(source: imageSource, imageQuality: 50);
    if (pickedImage == null) return;
    File img = File(pickedImage.path);
    File? cropped = await _cropImage(img);
    if (cropped == null) return;

    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PreviewImageScreen(
            imagePath: cropped.path,
            groupId: widget.chatScreenArguments.groupId,
            topicId: widget.chatScreenArguments.topicId,
            chatType: widget.chatScreenArguments.chatType,
          ),
        ),
      );
    }
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
      color: Theme.of(context).colorScheme.secondaryContainer,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
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
            ),
          if (!focused)
            IconButton(
              onPressed: () {
                _pickImages(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
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
              child: Icon(
                focused ? Icons.send : Icons.check_box,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
