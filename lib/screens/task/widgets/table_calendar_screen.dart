import 'package:check_bird/models/todo/todo.dart';
import 'package:check_bird/models/todo/todo_list_controller.dart';
import 'package:check_bird/screens/task/widgets/todo_item_remove.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarScreen extends StatefulWidget {
  static const routeName = '/task-calendar-screen';

  const TableCalendarScreen({Key? key}) : super(key: key);

  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final TodoListController _controller = TodoListController();
  final Box<Todo> box = TodoListController().getTodoList();
  late final ValueNotifier<List<Todo>> _selectedEvents;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_controller.getTaskForDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _controller.getTaskForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _controller.getTodoList().listenable(),
          builder: (context, Box<Todo> box, _) {
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(1970, 1, 1),
                  lastDay: DateTime.utc(2100, 1, 1),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  eventLoader: _controller.getTaskForDay,
                  onDaySelected: _onDaySelected,
                  calendarStyle: const CalendarStyle(outsideDaysVisible: false),
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 10.0),
                Expanded(
                    child: ValueListenableBuilder(
                  valueListenable: _controller.getTodoList().listenable(),
                  builder: (context, Box<Todo> box, _) {
                    final todos = _selectedEvents.value;
                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return ToDoItemRemove(todos: todos, index: index);
                      },
                    );
                  },
                ))
              ],
            );
          }),
    );
  }
}
