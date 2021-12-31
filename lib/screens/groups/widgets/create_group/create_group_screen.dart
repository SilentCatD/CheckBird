import 'dart:io';

import 'package:check_bird/screens/groups/models/groups_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum AppState {
  free,
  picked,
  cropped,
}

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  File? _image;
  AppState state = AppState.free;
  var _descriptionText = "";
  var _nameText = "";
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  bool get _hasContent {
    return  _nameText.trim().isNotEmpty;
  }

  void _submit(){
    GroupsController().createGroup(groupName: _nameText, groupDescription: _descriptionText, image: _image);
  }

  Future<void> _pickImage(ImageSource imageSource) async {
    var _pickedImg = await ImagePicker().pickImage(source: imageSource);
    if (_pickedImg != null) {
      setState(() {
        _image = File(_pickedImg.path);
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
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: _image!.path,
      cropStyle: CropStyle.rectangle,
      maxWidth: 180,
      maxHeight: 180,
      compressQuality: 50,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Cropper',
      ),
    );
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
          title: Text("Create group", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: _hasContent
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                    primary: Colors.black12),
                onPressed: _hasContent ? () {
                  _submit();
                  Navigator.pop(context);
                } : null,
                child: Text(
                  "Create group",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _hasContent ? Colors.white : null),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _pickImage(ImageSource.camera);
                    await _cropImage();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: _image != null
                          ? DecorationImage(image: Image.file(_image!).image)
                          : null,
                    ),
                    child: _image == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Take an image",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.image,
                                color: Colors.white,
                              )
                            ],
                          )
                        : null,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _clearImage();
                  },
                  child: const Text("Clear image"),
                ),
                TextField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  maxLength: 50,
                  decoration:
                  const InputDecoration(hintText: "Group name"),
                  onChanged: (value) {
                    setState(() {
                      _nameText = value;
                    });
                  },
                ),
                TextField(
                  controller: _descriptionController,
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:
                  const InputDecoration(hintText: "Group descriptions"),
                  onChanged: (value) {
                    setState(() {
                      _descriptionText = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: (){
            GroupsController().usersGroups();
          },
        ),
      ),
    );
  }
}
