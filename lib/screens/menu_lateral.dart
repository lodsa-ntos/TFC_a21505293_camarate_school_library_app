import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    //
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.blueAccent,
      screens: const [],
    );
  }

  final List<ScreenHiddenDrawer> _screens = [];
}

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}
