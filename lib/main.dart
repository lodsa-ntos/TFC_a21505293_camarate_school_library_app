import 'package:flutter/material.dart';
import 'package:camarate_school_library/home_screen.dart';
import 'drawer_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    // tirar o debug no ecrã
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Menu lateral
          DrawerScreen(),
          // Login screen (ainda nao implementado)
          HomeScreen(),
        ],
      ),
    );
  }
}
