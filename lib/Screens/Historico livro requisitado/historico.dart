import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/home/home_screen.dart';
import 'package:camarate_school_library/Screens/lista%20de%20livros/lista_livro_requisitado.dart';
import 'package:flutter/material.dart';

class Historico extends StatefulWidget {
  final List<Livro> livros;

  Historico(this.livros);

  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historico',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
