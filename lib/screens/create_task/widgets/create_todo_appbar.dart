import 'package:flutter/material.dart';

class CreateTodoAppbar extends StatelessWidget  implements PreferredSizeWidget{
  const CreateTodoAppbar({Key? key, required this.appBar}) : super(key: key);
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    // this is actually a transparent appbar, it should be considered to be made into essential widget
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      title: Text(
        "Create todo",
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
