import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/livro_detalhado.dart';
import 'package:flutter/material.dart';

class ListaDeLivrosDaPesquisa extends StatelessWidget {
  const ListaDeLivrosDaPesquisa({
    required this.livros,
    required this.ultimoLivro,
    Key? key,
  }) : super(key: key);

  final Livro livros;
  final bool ultimoLivro;

  @override
  Widget build(BuildContext context) {
    //** [ semLinhas ]  --> variável  */
    final semLinhas = GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          /// Redireciona o utilizador para a página de detalhes do livro
          builder: (context) => LivroDetalhado(livro: livros),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8,
          right: 8,
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                livros.imagePath,
                fit: BoxFit.cover,
                width: 80,
                height: 115,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      livros.titulo,
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    Text(
                      livros.autor,
                      style: const TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    Text(
                      'ISBN: ' + livros.isbn,
                      style: const TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // [ semLinhas ]  --> variável  */

    //* Se chegar ao ultimo livro não mostramos mais linhas a dividir
    if (ultimoLivro) {
      return semLinhas;
    }

    //** Aqui comeca o widget de construção */
    return Column(
      children: <Widget>[
        semLinhas,
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 0,
          ),
        ),
      ],
    );
  }
}
