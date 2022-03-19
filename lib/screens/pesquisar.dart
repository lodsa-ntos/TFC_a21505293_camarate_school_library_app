import 'package:camarate_school_library/Components/barra_de_pesquisa.dart';
import 'package:camarate_school_library/Components/livro_da_prateleira.dart';
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
      child: BarraDePesquisa(
        controlador: _controladorDoTexto,
        foco: _focarNaLetra,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repositorio =
        Provider.of<RepositorioDeLivros>(context, listen: false);
    final livros = repositorio.pesquisarLivro(_condicao);

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
              _controladorCaixaDePesquisa(),
              const SizedBox(height: 3),
              _buildFiltrarPesquisa(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => LivroDaPrateleira(
                    livros: livros[index],
                    ultimoLivro: index == livros.length - 1,
                  ),
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

Widget _buildFiltrarPesquisa() {
  List filtrarPor = [
    'Todos',
    'Autor',
    'Título',
    'Ano de publicação',
    'Editora'
  ]; // Lista de categorias
  int selecionarFiltro = 0;

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20.0 / 2),
    height: 35, // tamanho dos botões
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filtrarPor.length,
        itemBuilder: (context, index) {
          switch (selecionarFiltro) {
            case 0:
              index == selecionarFiltro
                  ? Text(
                      filtrarPor[index],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  //* e as retantes com a cor preta
                  : Text(
                      filtrarPor[index],
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    );
              break;
            case 1:
              index == selecionarFiltro
                  ? Text(
                      filtrarPor[index],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  //* e as retantes com a cor preta
                  : Text(
                      filtrarPor[index],
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    );
              break;
            default:
          }
          return GestureDetector(
            onTap: () => selecionarFiltro = index,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: 20.0, right: index == filtrarPor.length - 1 ? 20.0 : 0),

              /// Equilibrio na horizontal
              padding: const EdgeInsets.symmetric(horizontal: 20.0),

              //* Borda da caixas de filtro
              decoration: BoxDecoration(
                color: index == selecionarFiltro
                    ? Colors.blue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black12, width: 2.0),
              ),

              /// Codição --> //* Se o filtro estiver selecionado a palavra fica
              //* com cor branca
              child: index == selecionarFiltro
                  ? Text(
                      filtrarPor[index],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  //* e as retantes com a cor preta
                  : Text(
                      filtrarPor[index],
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
            ),
          );
        }),
  );
}
