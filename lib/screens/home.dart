import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // DateFormat

import 'lista_de_livros.dart';
import 'lista_livro_requisitado.dart';

//** VARIÁVEIS GLOBAIS */
// Espaçamento
const espacamento = SizedBox(
  height: 14,
);

// TÍtulo [Prateleiras]
const prateleiras = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Prateleiras',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

// TÍtulo [Livros Requisitados]
const livrosRequisitados = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Livros Requisitados',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

//** PÁGINA HOME */
// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //

    /// Página Home
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

      /// Este SingleChildScrollView será geral para toda a página home e fará apenas
      /// scroll na vertical
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // Título
            livrosRequisitados,

            //** Este SingleChildScrollView vai fazer scroll na horizontal
            //** vai apresentar os livros que foram requisitados */
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 310.0,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        //** Apresenta o livro requisitado no ecrã */
                        child: FormatoLivroRequisitadoParaUtilizador(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Título
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
                    itemBuilder: (context, index) =>
                        //** Livros da prateleira na página home */
                        ListaDeLivros(index: index),

                    //** Obter o tamanho maximo da minha lista, os valores
                    //** da lista estão contidos na classe GerarLivro */ */
                    itemCount: Provider.of<GerarLivro>(context, listen: false)
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
