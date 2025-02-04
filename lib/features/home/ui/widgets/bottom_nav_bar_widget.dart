import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavBarTapped;

  const BottomNavBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onNavBarTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 60.0,

      backgroundColor: Colors.transparent,
      color: Color(0xFF008080),
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.bolt, size: 30, color: Colors.white),
        Icon(Icons.search, size: 30, color: Colors.white),
        Icon(Icons.account_circle, size: 30, color: Colors.white),
      ],
      onTap: onNavBarTapped,
    );
  }
}
