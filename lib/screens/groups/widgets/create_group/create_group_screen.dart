import 'dart:io';

import 'package:check_bird/screens/group_detail/widgets/create_post/widgets/image_type_dialog.dart';
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
  const CreateGroupScreen({Key? key, this.group}) : super(key: key);
  final Group? group;

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  File? _image;
  AppState state = AppState.free;
  var _descriptionText = "";
  var _nameText = "";
  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();
  final _nameFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  bool get _hasContent {
    return _nameText.trim().isNotEmpty;
  }

  void _submit() {
    GroupsController().createGroup(
        groupName: _nameText,
        groupDescription: _descriptionText,
        image: _image);
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
  void initState() {
    super.initState();
    if (widget.group != null) {
      _nameController = TextEditingController(text: widget.group!.groupName);
      _descriptionController =
          TextEditingController(text: widget.group!.groupDescription);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: widget.group == null
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Theme.of(context).shadowColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  "Create group",
                  style: TextStyle(
                      color: Theme.of(context).splashColor,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: _hasContent
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                          primary: Colors.black12),
                      onPressed: _hasContent
                          ? () {
                              _submit();
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text(
                        "Create group",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _hasContent ? Colors.white : null),
                      )),
                ],
              )
            : null,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: widget.group == null
                      ? () async {
                          final useCam = await showDialog(
                              context: context,
                              builder: (context) {
                                return const ImageTypeDialog();
                              });
                          if(useCam==null)return;
                          if(useCam){
                            await _pickImage(ImageSource.camera);
                          }
                          else{
                            await _pickImage(ImageSource.gallery);
                          }
                          if (_image != null) {
                            await _cropImage();
                          }
                        }
                      : null,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: widget.group == null
                          ? _image != null
                              ? DecorationImage(
                                  image: Image.file(_image!).image)
                              : null
                          : widget.group!.groupsAvtUrl == null
                              ? null
                              : DecorationImage(
                                  image:
                                      Image.network(widget.group!.groupsAvtUrl!)
                                          .image),
                    ),
                    child: widget.group == null
                        ? _image == null
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
                            : null
                        : null,
                  ),
                ),
                if (widget.group == null)
                  ElevatedButton(
                    onPressed: () {
                      _clearImage();
                    },
                    child: const Text("Clear image"),
                  ),
                TextField(
                  enabled: widget.group == null,
                  controller: _nameController,
                  focusNode: _nameFocus,
                  maxLength: 50,
                  decoration: const InputDecoration(
                      hintText: "enter group's name...",
                      labelText: "Group's name"),
                  onChanged: (value) {
                    setState(() {
                      _nameText = value;
                    });
                  },
                ),
                TextField(
                  enabled: widget.group == null,
                  controller: _descriptionController,
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: "enter group's description...",
                      labelText: "Group's description"),
                  onChanged: (value) {
                    setState(() {
                      _descriptionText = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                if (widget.group != null)
                  FutureBuilder(
                    future: GroupsController()
                        .isJoined(groupId: widget.group!.groupId),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final isJoined = snapshot.data!;
                      if (isJoined) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            GroupsController()
                                .unJoinGroup(widget.group!.groupId);
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.exit_to_app),
                          label: const Text("Leave group"),
                        );
                      } else {
                        return ElevatedButton.icon(
                          onPressed: () {
                            GroupsController().joinGroup(widget.group!.groupId);
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.add_box),
                          label: const Text("Join group"),
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
