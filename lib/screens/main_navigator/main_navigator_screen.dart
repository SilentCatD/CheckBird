import 'package:animations/animations.dart';
import 'package:check_bird/screens/group/group_screen.dart';
import 'package:check_bird/screens/home/home_screen.dart';
import 'package:check_bird/screens/shop/shop_screen.dart';
import 'package:check_bird/screens/task/task_screen.dart';
import 'package:flutter/material.dart';

class MainNavigatorScreen extends StatefulWidget {
  static const routeName = '/main-navigation-screen';

  const MainNavigatorScreen({Key? key}) : super(key: key);

  @override
  _MainNavigatorScreenState createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  final List<Widget> _screen = const [
    HomeScreen(),
    TaskScreen(),
    GroupScreen(),
    ShopScreen(),
  ];

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
      extendBody: true,
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
        child: const Icon(Icons.add_circle_rounded),
        onPressed: () {},
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
              child: IconButton(onPressed: null, icon: Icon(Icons.add)),
              opacity: 0,
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
