import 'package:camarate_school_library/Screens/Home/Menu/menu_lateral.dart';
import 'package:camarate_school_library/Screens/Home/home_screen.dart';
import 'package:flutter/material.dart';

class LayoutPaginaPrincipal extends StatefulWidget {
  const LayoutPaginaPrincipal({Key? key}) : super(key: key);

  @override
  _LayoutPaginaPrincipalState createState() => _LayoutPaginaPrincipalState();
}

class _LayoutPaginaPrincipalState extends State<LayoutPaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MenuLateral(),
          HomeScreen(),
        ],
      ),
    );
  }
}
