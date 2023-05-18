import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/widgets/app_bars/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required this.child, super.key});

  final Widget child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: widget.child,
      bottomNavigationBar: CustomBottomNavBar(
        items: tabs,
        currentIndex: _currentIndex,
        onItemTap: (index) => _onItemTapped(context, index),
      ),
    );
  }

  static const tabs = [
    CustomNavBarItem(
      initialLocation: '/home',
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    CustomNavBarItem(
      icon: Icon(Icons.notifications),
      label: 'Notifications',
      initialLocation: '/notifications',
    ),
    CustomNavBarItem(
      icon: Icon(Icons.more_horiz),
      label: 'More',
      initialLocation: '/more',
    ),
  ];
}
