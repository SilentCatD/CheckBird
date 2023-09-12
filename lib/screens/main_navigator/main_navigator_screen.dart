import 'package:animations/animations.dart';
import 'package:check_bird/screens/create_task/create_todo_screen.dart';
import 'package:check_bird/screens/groups/groups_screen.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:check_bird/screens/shop/shop_screen.dart';
import 'package:check_bird/screens/task/task_screen.dart';
import 'package:check_bird/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class MainNavigatorScreen extends StatefulWidget {
  static const routeName = '/main-navigation-screen';

  const MainNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  late List<Widget> _screen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screen = [
      HomeScreen(changeTab: changeTag),
      const TaskScreen(),
      const GroupScreen(),
      const ShopScreen(),
    ];
  }

  void changeTag(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  int _selectedScreenIndex = 0;

  Widget _buildTabItem({required int index, required Icon icon}) {
    final isSelected = (index == _selectedScreenIndex);
    return IconTheme(
      data: IconThemeData(
        color: isSelected ? Colors.white : Colors.white54,
      ),
      child: IconButton(
        iconSize: 30,
        icon: icon,
        onPressed: () {
          setState(() {
            _selectedScreenIndex = index;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: PageTransitionSwitcher(
        transitionBuilder: (Widget child, Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation) {
          return FadeTransition(
            opacity: primaryAnimation,
            child: child,
          );
        },
        child: _screen[_selectedScreenIndex],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_task,
          size: 40,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) =>
                    const CreateTodoScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabItem(index: 0, icon: const Icon(Icons.home_rounded)),
            _buildTabItem(index: 1, icon: const Icon(Icons.checklist_rounded)),
            const Opacity(
              opacity: 0,
              child: IconButton(onPressed: null, icon: Icon(Icons.add)),
            ), // dirty way to space items
            _buildTabItem(index: 2, icon: const Icon(Icons.groups_rounded)),
            _buildTabItem(
                index: 3, icon: const Icon(Icons.shopping_bag_rounded)),
          ],
        ),
      ),
    );
  }
}
