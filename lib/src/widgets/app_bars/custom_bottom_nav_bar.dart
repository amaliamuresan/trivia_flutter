import 'package:flutter/material.dart';
import 'package:trivia_app/src/style/style.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onItemTap,
    required this.items,
    super.key,
  });

  final int currentIndex;
  final void Function(int) onItemTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:  AppColors.surface,
      currentIndex: currentIndex,
      onTap: onItemTap,
      items: items,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.greyLight,
      enableFeedback: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}

class CustomNavBarItem extends BottomNavigationBarItem {
  const CustomNavBarItem({
    required this.initialLocation,
    required super.icon,
    super.label,
  });

  final String initialLocation;
}
