import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class PesquisaScreen extends StatefulWidget {
  @override
  _PesquisaScreenState createState() => _PesquisaScreenState();
}

class _PesquisaScreenState extends State<PesquisaScreen> {
  // Lista vazia para encontrar e guardar utilizadores
  List<Map<String, dynamic>> _encontrarUtilizadores = [];

  void _filtrarPesquisa(String campoDePesquisa) {
    // Lista de utilizadores
    final List<Map<String, dynamic>> _mostrarTodosUtilizadores = [
      {"id": 1, "name": "Andy", "age": 29},
      {"id": 2, "name": "Krisby", "age": 19},
      {"id": 3, "name": "Zé", "age": 32},
      {"id": 4, "name": "Miguel", "age": 25},
      {"id": 5, "name": "Telma", "age": 44},
      {"id": 6, "name": "Aragon", "age": 30},
      {"id": 7, "name": "Lidya", "age": 38},
      {"id": 8, "name": "Gustav", "age": 17},
      {"id": 9, "name": "Maria", "age": 23},
      {"id": 10, "name": "Ernildo", "age": 51},
      {"id": 11, "name": "Barbara", "age": 12},
      {"id": 12, "name": "Bob", "age": 62},
    ];
  }

  // Widget de construção da página, conteúdo visual.
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            // ignore: deprecated_member_use
            textTheme: Theme.of(context).textTheme,
          ),
        ),
        child: Scaffold(
          //backgroundColor: Colors.green,
          appBar: AppBar(
            title: Text(
              'Pesquisar',
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily, // mudar font...?
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.bold, // italic
              ),
            ),
          ),
          body: const Center(
            child: Text("Books"),
          ),
        ));
  }
}
