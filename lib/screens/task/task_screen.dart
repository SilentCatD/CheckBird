import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/screens/task/widgets/habit_list.dart';
import 'package:check_bird/screens/task/widgets/remove_all_item_ad.dart';
import 'package:check_bird/screens/task/widgets/table_calendar_screen.dart';
import 'package:check_bird/screens/task/widgets/todo_list_main.dart';
import 'package:check_bird/widgets/focus/focus_widget.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  static const routeName = '/task-screen';

  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              // TODO: change icons here
              Tab(icon: Icon(Icons.library_add_check)),
              Tab(icon: Icon(Icons.image_aspect_ratio)),
              Tab(icon: Icon(Icons.sync)),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: const Text("Task"),
          actions: [
            const FocusButton(),
            PopupMenuButton(
              onSelected: (item) async {
                if (item == 0) {
                  final bool? agree = await showDialog(
                      context: context,
                      builder: (context) {
                        return const RemoveAllItemAD();
                      });
                  if (agree != null && agree == true) {
                    TodoListController().removeAllTodo();
                  }
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 0,
                    child: Text("Remove all todo"),
                  )
                ];
              },
            ),
          ],
        ),
        // TODO: add more screen here
        body: TabBarView(children: [
          ToDoListMain(today: today),
          const TableCalendarScreen(),
          const HabitListScreen(),
        ]),
      ),
    );
  }
}
