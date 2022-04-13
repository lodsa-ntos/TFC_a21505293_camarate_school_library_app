import 'package:camarate_school_library/Database/base_de_dados.dart';
import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'Components/construir_caixa_pesquisa.dart';
import 'Components/construir_filtros_pesquisa.dart';
import 'Components/lista_livros_pesquisa.dart';

String _condicao = '';

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

  @override
  void initState() {
    super.initState();
    _controladorDoTexto = TextEditingController()..addListener(_onTextChanged);
    _focarNaLetra = FocusNode();
  }

  //* Limpar espaços da memória
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
    final referenciaBD = FirebaseDatabase.instance.ref().child('livros');
    final fazerLigacao = BaseDeDados();

    final pesquisarLivrosBD = FutureBuilder(
      future: fazerLigacao.carregarLivrosBD(referenciaBD),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else {
              /// snapshot.data --> livros da bases de dados
              final result = _filtrarPesquisa(snapshot.data);
              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,

                  // Até ao último livro da lista
                  itemCount: result.length,
                  // Mostra todos os livros da lista contidos na base de dados
                  itemBuilder: (context, index) {
                    return ListaDeLivrosDaPesquisa(
                      // Obter todos os index da lista de livros da base de dados
                      livros: result[index],
                      ultimoLivro: index == result.length - 1,
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

List<LivroModel> _filtrarPesquisa(List<LivroModel>? caixaDePesquisa) {
  if (_condicao.isNotEmpty == true) {
    //* Título
    if (selecionarFiltro == 0) {
      return caixaDePesquisa
              ?.where(
                (element) => element.titulo
                    .toString()
                    .toLowerCase()
                    .contains(_condicao.toLowerCase()),
              )
              .toList() ??
          <LivroModel>[];

      //* Autor
    } else if (selecionarFiltro == 1) {
      return caixaDePesquisa
              ?.where(
                (element) => element.autor
                    .toString()
                    .toLowerCase()
                    .contains(_condicao.toLowerCase()),
              )
              .toList() ??
          <LivroModel>[];

      //* Título
    } else if (selecionarFiltro == 2) {
      return caixaDePesquisa
              ?.where(
                (element) => element.titulo
                    .toString()
                    .toLowerCase()
                    .contains(_condicao.toLowerCase()),
              )
              .toList() ??
          <LivroModel>[];

      //* Ano de publicação
    } else if (selecionarFiltro == 3) {
      return caixaDePesquisa
              ?.where(
                (element) => element.ano
                    .toString()
                    .toLowerCase()
                    .contains(_condicao.toLowerCase()),
              )
              .toList() ??
          <LivroModel>[];
    }
  }

  return caixaDePesquisa ?? <LivroModel>[];
}
