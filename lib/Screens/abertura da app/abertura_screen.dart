import 'dart:async';

import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class AberturaScreen extends StatefulWidget {
  const AberturaScreen({Key? key}) : super(key: key);

  @override
  _AberturaScreenState createState() => _AberturaScreenState();
}

// Duração do ecrã de abertura da app antes de entrar na página do Login
class _AberturaScreenState extends State<AberturaScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logotipo
            Image.asset(
              'assets/images/logotipos/logotipo.png',
              height: 259.0,
            ),
            const Text(
              'Camarate',
              style: TextStyle(
                fontFamily: 'Gobold',
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: Color.fromRGBO(51, 51, 51, 2),
              ),
            ),
            const Text(
              'School Library',
              style: TextStyle(
                fontFamily: 'Gobold',
                fontWeight: FontWeight.w300,
                fontSize: 36,
                color: Color.fromRGBO(51, 51, 51, 2),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
