import 'package:camarate_school_library/Components/barra_de_pesquisa.dart';
import 'package:camarate_school_library/Components/livro_da_prateleira.dart';
import 'package:camarate_school_library/Models/repositorio_de_livros.dart';
import 'package:camarate_school_library/Models/livro.dart';
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
              const SizedBox(height: 15),
              const FiltrarPesquisa(),
              const SizedBox(height: 20),
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

class FiltrarPesquisa extends StatefulWidget {
  const FiltrarPesquisa({Key? key}) : super(key: key);

  @override
  State<FiltrarPesquisa> createState() => _FiltrarPesquisaState();
}

class _FiltrarPesquisaState extends State<FiltrarPesquisa> {
  // Lista de categorias
  int selecionarFiltro = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children: List.generate(
              menuDoFiltro.length,
              (index) => InkWell(
                //* Ação para mudar de filtro
                onTap: () {
                  setState(() {
                    selecionarFiltro = index;
                  });
                },
                child: Container(
                  //* Alinhamento das palavras no retangulo dos filtros
                  alignment: Alignment.center,

                  margin: EdgeInsets.only(
                    left: 17.0,
                    right: index == menuDoFiltro.length - 1 ? 20.0 : 0,
                  ),

                  //* Comportamento quando um filtro é selecionado
                  decoration: BoxDecoration(
                    color: selecionarFiltro == index
                        ? Colors.blue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black12, width: 2.0),
                  ),

                  //* Comprimento e largura dos retangulos do filtro
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),

                    //* Comportamento do texto quando é selecionado um filtro
                    child: Text(
                      menuDoFiltro[index],
                      style: TextStyle(
                        color: selecionarFiltro == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
