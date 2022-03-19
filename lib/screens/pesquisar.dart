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

  Widget _buildFiltrarPesquisa() {
    List menuFiltrarPor = [
      'Todos',
      'Autor',
      'Título',
      'Ano de publicação',
      'Editora'
    ]; // Lista de categorias
    int selecionarFiltro = 0;

    return Column(
      children: [
        Row(
          children: List.generate(
            menuFiltrarPor.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  selecionarFiltro = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: selecionarFiltro == index
                        ? Colors.grey[200]
                        : Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 0.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    child: Text(
                      menuFiltrarPor[index],
                      style: TextStyle(
                        color: selecionarFiltro == index
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
