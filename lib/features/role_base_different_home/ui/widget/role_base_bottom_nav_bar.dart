import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class RoleBaseBottomNavBarWidget extends StatefulWidget {
  final int currentIndexRoleBase;
  final Function(int) onNavBarTappedRoleBase;

  const RoleBaseBottomNavBarWidget({
    Key? key,
    required this.currentIndexRoleBase,
    required this.onNavBarTappedRoleBase,
  }) : super(key: key);

  @override
  _RoleBaseBottomNavBarWidgetState createState() =>
      _RoleBaseBottomNavBarWidgetState();
}

class _RoleBaseBottomNavBarWidgetState
    extends State<RoleBaseBottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: widget.currentIndexRoleBase,
      height: 60.0,
      backgroundColor: Colors.transparent,
      color: const Color(0xFF008080),
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.account_circle, size: 30, color: Colors.white),
      ],
      onTap: widget.onNavBarTappedRoleBase,
    );
  }
}
