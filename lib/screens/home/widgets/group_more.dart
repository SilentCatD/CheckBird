
import 'package:check_bird/screens/groups/groups_screen.dart';
import 'package:flutter/material.dart';

class GroupMore extends StatelessWidget {
  const GroupMore({Key? key,required this.changeTab}) : super(key: key);
  final void Function(int index) changeTab;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          changeTab(2);
        },
        child: SizedBox(
          width: size.width * 0.2,
          child: Column(
            children: const [
               CircleAvatar(
                radius: 37,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.add),
                ),
              ),
              Text("More",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold)
              ),
            ],
          ),
        )
    );
  }
}