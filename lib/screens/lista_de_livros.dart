import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'livro_detalhado.dart';

class ListaDeLivros extends StatelessWidget {
  const ListaDeLivros({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var livros = context.select<GerarLivro, Livro>(
      // Aqui, apenas interessa o livro a partir do [index].
      (livro) => livro.getPorId(index),
    );

    // Um pequeno tema para o texto(titulo, subTitulo, etc)
    var textTheme = Theme.of(context).textTheme.headline6;

    // Aqui o utilizador consegue carregar em cima do livro e ser direcionado para o ecrã de livro detalhado
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LivroDetalhado(
              livro: livros,
            ),
          ),
        );
      },

      // O formato dos livros a ser representado antes de entrar no ecrã do livro detalhado
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
                          image: NetworkImage(livros.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      livros.titulo,
                      style: textTheme,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
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
