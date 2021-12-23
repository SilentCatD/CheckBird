import 'package:check_bird/screens/test/widgets/week_day_picker/week_day_picker.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);
  static const routeName = '/test-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: WeekDayPicker(
        onChanged: (days) {
          print(days);
        },
      ),
    ));
  }
}
