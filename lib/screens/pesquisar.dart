import 'package:camarate_school_library/Database/base_de_dados.dart';
import 'package:camarate_school_library/Database/repositorio_de_livros.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/construir_caixa_pesquisa.dart';
import 'Components/construir_filtros_pesquisa.dart';
import 'Components/lista_livros_pesquisa.dart';

class PesquisaDeLivro extends StatefulWidget {
  const PesquisaDeLivro({Key? key}) : super(key: key);

  @override
  _PesquisaDeLivroState createState() {
    return _PesquisaDeLivroState();
  }
}

class _PesquisaDeLivroState extends State<PesquisaDeLivro> {
  late final TextEditingController _controladorDoTexto;
  late final FocusNode _focarNaLetra;
  String _condicao = '';

  @override
  void initState() {
    super.initState();
    _controladorDoTexto = TextEditingController()..addListener(_onTextChanged);
    _focarNaLetra = FocusNode();
  }

  //* Limpara espaços da memória
  @override
  void dispose() {
    _focarNaLetra.dispose();
    _controladorDoTexto.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _condicao = _controladorDoTexto.text;
    });
  }

  Widget _controladorCaixaDePesquisa() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ConstruirCaixaDePesquisa(
        controlador: _controladorDoTexto,
        foco: _focarNaLetra,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final referenciaBD =
        FirebaseDatabase.instance.ref().child('livrosAleatorios');
    final fazerLigacao = BaseDeDados();

    final pesquisarLivrosBD = FutureBuilder(
      future: fazerLigacao.carregarLivrosBD(referenciaBD), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else {
              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,

                  // Até ao último livro da lista
                  itemCount: snapshot.data.length,
                  // Mostra todos os livros da lista
                  itemBuilder: (context, index) {
                    return ListaDeLivrosDaPesquisa(
                      livros: snapshot.data[index],
                      ultimoLivro: index == snapshot.data.length - 1,
                    );
                  },
                ),
              );
            }
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar'), // Título
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xfff0f0f0),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              //* Barra de pesquisa
              _controladorCaixaDePesquisa(),

              const SizedBox(height: 15),

              //* Filtros para pesquisar pesquisa
              const ConstruirFiltrosDePesquisa(),

              const SizedBox(height: 20),

              //* Livros
              pesquisarLivrosBD,
            ],
          ),
        ),
      ),
    );
  }
}
