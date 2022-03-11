import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import 'livro_detalhado.dart';

//** Classe para apresentar os livros na página home*/
class ListaDeLivros extends StatelessWidget {
  const ListaDeLivros({Key? key, required this.index}) : super(key: key);

  //** Variável para alcançar os livros por id na lista que gera livros */
  final int index;

  @override
  Widget build(BuildContext context) {
    var livros = context.select<GerarLivro, Livro>(
      // Aqui, apenas interessa o livro a partir do [index].
      (livro) => livro.getPorId(index),
    );

    // Um pequeno tema para o texto(titulo, subTitulo, etc)
    var textTheme = Theme.of(context).textTheme.headline6;

    return GestureDetector(
      //** Aqui o utilizador consegue carregar em cima do livro
      //** e ser direcionado para o ecrã de livro detalhado */
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            //** Redirecionado para a página de detalhes do livro */
            builder: (context) => LivroDetalhado(livro: livros),
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
