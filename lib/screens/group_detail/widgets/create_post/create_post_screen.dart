import 'dart:io';

import 'package:check_bird/screens/group_detail/models/posts_controller.dart';
import 'package:check_bird/screens/group_detail/widgets/create_post/widgets/image_type_dialog.dart';
import 'package:check_bird/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum AppState {
  free,
  picked,
  cropped,
}

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, required this.groupId});
  final String groupId;
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool get _hasContent {
    return _image != null || _enteredText.trim().isNotEmpty;
  }

  // change type to File?
  File? _image;
  String _enteredText = "";
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  AppState state = AppState.free;

  Future<void> _pickImage(ImageSource imageSource) async {
    var pickedImg = await ImagePicker().pickImage(source: imageSource);
    if (pickedImg != null) {
      setState(() {
        _image = File(pickedImg.path);
        state = AppState.picked;
      });
    }
  }

  void _clearImage() {
    _image = null;
    setState(() {
      state = AppState.free;
    });
  }

  Future<void> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
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
      _image = File(croppedFile.path);
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.black12,
                    backgroundColor: _hasContent
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300),
                onPressed: _hasContent
                    ? () {
                        PostsController().createPostInDB(
                            groupId: widget.groupId,
                            text: _enteredText,
                            img: _image);
                        Navigator.pop(context);
                      }
                    : null,
                child: Text(
                  "Post",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _hasContent ? Colors.white : null),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(Authentication.user!.photoURL!),
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Authentication.user!.displayName!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          Authentication.user!.email!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:
                      const InputDecoration(hintText: "What's on your mind?"),
                  onChanged: (value) {
                    setState(() {
                      _enteredText = value;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: _image == null
                      ? ElevatedButton(
                          child: const Text("Add image"),
                          onPressed: () async {
                            if (_focusNode.hasPrimaryFocus) {
                              _focusNode.unfocus();
                            }
                            final useCam = await showDialog(
                                context: context,
                                builder: (context) {
                                  return const ImageTypeDialog();
                                });
                            if (useCam == null) return;
                            if (useCam) {
                              await _pickImage(ImageSource.camera);
                            } else {
                              await _pickImage(ImageSource.gallery);
                            }
                            await _cropImage();
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: const Text("Remove"),
                              onPressed: () {
                                if (_focusNode.hasPrimaryFocus) {
                                  _focusNode.unfocus();
                                }
                                _clearImage();
                              },
                            ),
                            ElevatedButton(
                              child: const Text("Edit"),
                              onPressed: () async {
                                if (_focusNode.hasPrimaryFocus) {
                                  _focusNode.unfocus();
                                }
                                await _cropImage();
                              },
                            ),
                            ElevatedButton(
                              child: const Text("Pick another"),
                              onPressed: () async {
                                if (_focusNode.hasPrimaryFocus) {
                                  _focusNode.unfocus();
                                }
                                _clearImage();
                                final useCam = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ImageTypeDialog();
                                    });
                                if (useCam == null) return;
                                if (useCam) {
                                  await _pickImage(ImageSource.camera);
                                } else {
                                  await _pickImage(ImageSource.gallery);
                                }
                                await _cropImage();
                              },
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                if (_image != null)
                  Center(
                    child:
                        SizedBox(width: size.width, child: Image.file(_image!)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
