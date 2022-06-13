import 'package:camarate_school_library/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class _MenuLateralState extends State<MenuLateral> {
  @override
  void initState() {
    _screens = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: const TextStyle(),
          selectedStyle: const TextStyle(),
        ),
        const Home(),
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.blueAccent,
      screens: _screens,
      initPositionSelected: 0,
    );
  }

  List<ScreenHiddenDrawer> _screens = [];
}

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}
