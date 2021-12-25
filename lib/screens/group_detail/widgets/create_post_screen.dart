import 'package:check_bird/services/authentication.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // When finished, return post object by Navigator.of(context).pop(newPost);

  bool _hasContent = false;
  // change type to File?
  String? image;

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
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
                    backgroundColor: _hasContent
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                    primary: Colors.black12),
                onPressed: _hasContent ? () {} : null,
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
                  focusNode: _focusNode,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:
                      const InputDecoration(hintText: "What's on your mind?"),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: image == null ? ElevatedButton(
                    child: const Text("Add image"),
                    onPressed: (){
                      if (_focusNode.hasPrimaryFocus) _focusNode.unfocus();
                      setState(() {
                        // TODO: open img picker
                        image = 'a';
                      });
                    },
                  ) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text("Remove"),
                        onPressed: (){
                          if (_focusNode.hasPrimaryFocus) _focusNode.unfocus();
                          setState(() {
                            image = null;
                          });
                        },
                      ),
                      ElevatedButton(
                        child: const Text("Edit"),
                        onPressed: (){
                          if (_focusNode.hasPrimaryFocus) _focusNode.unfocus();
                          // TODO: open img cropper
                        },
                      ),
                      ElevatedButton(
                        child: const Text("Pick another"),
                        onPressed: (){
                          if (_focusNode.hasPrimaryFocus) _focusNode.unfocus();
                          // TODO: open img picker

                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
