import 'package:camarate_school_library/paginas/authLogin/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:camarate_school_library/paginas/home_screen.dart';
import 'ferramentas/drawer_screen.dart';
import 'paginas/home_screen.dart';

void main() {
  runApp(
    CamarateSchoolLibraryApp(),
  );
}

// ignore: use_key_in_widget_constructors
class CamarateSchoolLibraryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // tirar o debug no ecrã
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Menu lateral
            DrawerScreen(),
            // Login screen (ainda nao implementado)
            HomeScreen(),
          ],
        ),
        // recommended to set this to false
        // so user keyboard doesn't trigger resize
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
