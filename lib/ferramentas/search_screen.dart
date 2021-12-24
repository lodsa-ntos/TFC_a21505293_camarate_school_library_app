import 'package:camarate_school_library/lista_livros/books_widget.dart';
import 'package:camarate_school_library/lista_livros/inventory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camarate_school_library/guia_de_estilo/text_styles.dart';

// ignore: use_key_in_widget_constructors
class PesquisaScreen extends StatefulWidget {
  @override
  _PesquisaScreenState createState() => _PesquisaScreenState();
}

class _PesquisaScreenState extends State<PesquisaScreen> {
  List categorias = ['Todos', 'Autor', 'Título', 'Ano']; // Lista de categorias
  int selecionarCategorias = 0;

  // Widget de construção da página, conteúdo visual.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Pesquisar",
              style: headingTextStyle.copyWith(color: Colors.black),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Pesquise o seu livro...",
                ),
              ),
            ),
          ),

          // --> Botões para as categorias
          Container(
            margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            height: 35, // tamanho dos botões
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categorias.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selecionarCategorias = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: kDefaultPadding,
                      right:
                          index == categorias.length - 1 ? kDefaultPadding : 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: index == selecionarCategorias
                        ? Colors.blue.withOpacity(0.4)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Text(
                    categorias[index],
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ),
          ),
          // fim de botões para as categorias...

          // Espaçamento entre botões categorias e a lista de livros
          const SizedBox(
            height: 10,
          ),

          // --> Lista para os livros
          Expanded(
            child: ListView.builder(
              // tamanho dos retângulos
              padding: const EdgeInsets.all(7),
              // tamanho da lista a ser apresentada
              itemCount: Inventario.books.length,
              itemBuilder: (context, index) {
                // Lista que retorna apenas o titulo | autor | imagem ....
                return BooksWidget(
                  // lista contida na classe inventarios --> pasta lista_livros
                  books: Inventario.books[index],
                );
              }, //itemCount: ,
            ),
          ),
        ],
      ),
    );
  }
}
