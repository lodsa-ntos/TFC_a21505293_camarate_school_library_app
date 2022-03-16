import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Models/livro_requisitado_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'livro_detalhado.dart';

//** VARIÁVEIS GLOBAIS */
//* Espaçamento
const espacamento = SizedBox(
  height: 14,
);

//* TÍtulo [Prateleiras]
const prateleiras = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Prateleiras',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

//* TÍtulo [Livros Requisitados]
const livrosRequisitados = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Livros Requisitados',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

//* PÁGINA HOME
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //** Variável para alcançar os livros por id na lista que gera livros */
    final int index;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros'), // Título

        actions: <Widget>[
          //** Icone de pesquisa */
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],

        //** Icone Menu lateral */
        leading: IconButton(
          icon: const Icon(Icons.menu_outlined),
          onPressed: () {},
        ),
      ),

      //* Este SingleChildScrollView será geral para toda a página home e fará apenas
      //* scroll na vertical
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            //* Título
            livrosRequisitados,

            //** Este SingleChildScrollView vai fazer scroll na horizontal
            //** vai apresentar os livros que foram requisitados */
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 310.0,
                child: Column(
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),

                        //** Apresenta o livro requisitado no ecrã */
                        child: ListaDeLivroRequisitado(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //* Título
            prateleiras,
            //
            //** Este SingleChildScrollView vai fazer scroll na horizontal
            //** e irá apresentar os livros das prateleiras */
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 375.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    //** comportamento para que a ListView só ocupe o espaço que precisa */
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        //** Livros da prateleira na página home */
                        ListaDeLivros(index: index),

                    //** Obter o tamanho maximo da minha lista, os valores
                    //** da lista estão contidos na classe GerarLivro */ */
                    itemCount:
                        Provider.of<RequisicaoModel>(context, listen: false)
                            .gerarLivrosAleatorios
                            .length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//* LISTA SE UM LIVRO FOR REQUISITADO

class ListaDeLivroRequisitado extends StatelessWidget {
  const ListaDeLivroRequisitado({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //** Consumer */
    return Consumer<LivroRequisitadoModel>(
      //** (context, requisicao, child) --> variaveis */
      builder: (context, requisicao, child) => ListView.builder(
        scrollDirection: Axis.horizontal,

        //** tamanho máximo da lista para a requisicão */
        itemCount: requisicao.livros.length,

        itemBuilder: (context, index) => InkWell(
          //* Aqui o utilizador consegue carregar em cima do livro
          //* e ser direcionado para o ecrã de livro detalhado
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              //** Redireciona o utilizador para a página de detalhes do livro */
              builder: (context) => LivroDetalhado(
                livro: requisicao.livros[index],
              ),
            ),
          ),

          //* Widgets que vão reconstruir o formato dos livros a serem apresentados
          //* no página home
          child: Row(
            children: [
              Container(
                width: 111.0,
                margin: const EdgeInsets.only(right: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 121.66,
                      height: 165.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          //** Capa */
                          image:
                              NetworkImage(requisicao.livros[index].imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    //** Titulo */
                    Text(
                      requisicao.livros[index].titulo,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    ),

                    const SizedBox(height: 5.0),

                    //** Data: */
                    Text(
                      'Data da requisição: ' + requisicao.livros[index].data,
                      style: GoogleFonts.catamaran(
                        textStyle: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//* LISTA DE LIVROS PRATELEIRAS

class ListaDeLivros extends StatelessWidget {
  const ListaDeLivros({Key? key, required this.index}) : super(key: key);

  //** Variável para alcançar os livros por id na lista livros */
  final int index;

  @override
  Widget build(BuildContext context) {
    var livros = context.select<RequisicaoModel, Livro>(
      // Aqui, apenas interessa o livro a partir do [index].
      (livro) => livro.getPorId(index),
    );

    // Um pequeno tema para o texto(titulo, subTitulo, etc)
    var textTheme = Theme.of(context).textTheme.headline6;

    return GestureDetector(
      //* Aqui o utilizador consegue carregar em cima do livro
      //* e ser direcionado para o ecrã de livro detalhado
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            //** Redireciona o utilizador para a página de detalhes do livro */
            builder: (context) => LivroDetalhado(
              livro: livros,
            ),
          ),
        );
      },

      //** Widgets que vão desenvolver formato dos livros a serem apresentados
      //** no página home */
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        child: LimitedBox(
          maxHeight: 48,
          child: Row(
            children: [
              Container(
                width: 122.0,
                margin: const EdgeInsets.only(right: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 121.66,
                      height: 190.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          //** Capa */
                          image: NetworkImage(livros.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12.0),

                    //** Titulo */
                    Text(livros.titulo, style: textTheme),

                    const SizedBox(height: 5.0),

                    //** Autor */
                    Text(livros.autor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
