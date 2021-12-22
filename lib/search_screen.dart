import 'package:flutter/material.dart';

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

    @override
    initState() {
      // quando clicar no botão de pesquisa, no início, todos os utilizadores são mostrados
      _encontrarUtilizadores = _mostrarTodosUtilizadores;
      super.initState();
    }

    // Lista de resultados
    List<Map<String, dynamic>> resultados = [];

    // se o campo de pesquisa estiver vazio, mostramos a lista de todos os utilizadores iniciais
    if (campoDePesquisa.isEmpty) {
      // lista resultados recebe todos os utilizadores criados no início
      resultados = _mostrarTodosUtilizadores;
    } else {
      // senão, se escrever no campo de pesquisa, com minusculas ou com as inicias dos nomes,
      //convertemos para lista e ocultamos os outros nomes e mostramos
      //o resultado da pesquisa ao nome associado...
      resultados = _mostrarTodosUtilizadores
          .where((user) => user["name"]
              .toLowerCase()
              .contains(campoDePesquisa.toLowerCase()))
          .toList();
    }

    // atualizar a lista inicial, com os novos resultados da pesquisa.
    setState(() {
      _encontrarUtilizadores = resultados;
    });
  }

  // Widget de construção da página, conteúdo visual.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisa'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => _filtrarPesquisa(value),
                decoration: const InputDecoration(
                    labelText: 'Pesquisar', suffixIcon: Icon(Icons.search)),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _encontrarUtilizadores.isNotEmpty
                    ? ListView.builder(
                        itemCount: _encontrarUtilizadores.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_encontrarUtilizadores[index]["id"]),
                          color: Colors.yellow,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Text(
                              _encontrarUtilizadores[index]["id"].toString(),
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(_encontrarUtilizadores[index]['name']),
                            subtitle: Text(
                                '${_encontrarUtilizadores[index]["age"].toString()} years old'),
                          ),
                        ),
                      )
                    : const Text(
                        'Nenhum resultado encontrado',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
