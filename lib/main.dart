import 'dart:async';

import 'package:camarate_school_library/Autenticacao/Login/ecra_login.dart';
import 'package:camarate_school_library/Home/home_screen.dart';
import 'package:camarate_school_library/Home/layout/layout_pagina_utilizador.dart';
import 'package:flutter/material.dart';

import 'Autenticacao/Registo/pagina_registo.dart';

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
          children: const [
            // Abertura da página
            EcraDeAberturaDaApp(),
          ],
        ),
        // para que o teclado do utilizador não acione o redimensionamento
        //da página
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class EcraDeAberturaDaApp extends StatefulWidget {
  const EcraDeAberturaDaApp({Key? key}) : super(key: key);

  @override
  _EcraDeAberturaDaAppState createState() => _EcraDeAberturaDaAppState();
}

class _EcraDeAberturaDaAppState extends State<EcraDeAberturaDaApp> {
  @override
  void initState() {
    super.initState();
    // Duração da página de ecrã de abertura da app
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const PaginaLogin(),
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
