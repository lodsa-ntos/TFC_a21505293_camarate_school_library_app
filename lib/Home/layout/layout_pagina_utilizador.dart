import 'package:camarate_school_library/Home/Menu/menu_lateral.dart';
import 'package:camarate_school_library/Home/home_screen.dart';
import 'package:flutter/material.dart';

class LayoutPaginaPrincipalUtilizador extends StatefulWidget {
  const LayoutPaginaPrincipalUtilizador({Key? key}) : super(key: key);

  @override
  _LayoutPaginaPrincipalUtilizadorState createState() =>
      _LayoutPaginaPrincipalUtilizadorState();
}

class _LayoutPaginaPrincipalUtilizadorState
    extends State<LayoutPaginaPrincipalUtilizador> {
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
