import 'package:flutter/material.dart';

class CreateTodoAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CreateTodoAppbar({Key? key, required this.appBar, this.todoName})
      : super(key: key);
  final AppBar appBar;
  final String? todoName;

  @override
  Widget build(BuildContext context) {
    // this is actually a transparent appbar, it should be considered to be made into essential widget
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      title: Text(
        todoName == null ? "Create todo" : "Edit todo",
        style:  TextStyle(
          color: Theme.of(context).shadowColor,
            fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Theme.of(context).shadowColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
