import 'package:camarate_school_library/Components/construir_caixa_pesquisa.dart';
import 'package:camarate_school_library/Components/construir_filtros_pesquisa.dart';
import 'package:camarate_school_library/Components/lista_livros_pesquisa.dart';
import 'package:camarate_school_library/Models/repositorio_de_livros.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    //* Variavel para aceder a funcão --> [ filtrarPesquisa ]
    final repositorio =
        Provider.of<RepositorioDeLivros>(context, listen: false);

    //* Função para a condição da pesquisa por filtros
    final livros = repositorio.filtrarPesquisa(_condicao);

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
              Expanded(
                child: ListView.builder(
                  //* Mostra todos os livros da lista
                  itemBuilder: (context, index) => ListaDeLivrosDaPesquisa(
                    livros: livros[index],
                    ultimoLivro: index == livros.length - 1,
                  ),
                  //* Até ao último livro da lista
                  itemCount: livros.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
