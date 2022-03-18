// ignore: use_key_in_widget_constructors

import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'livro_detalhado.dart';

class Pesquisar extends StatefulWidget {
  const Pesquisar({Key? key}) : super(key: key);

  @override
  State<Pesquisar> createState() => _PesquisarState();
}

class _PesquisarState extends State<Pesquisar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(height: 30),
          // Campo para fazer a pesquisa do livro
          BarraDaPesquisa(),
        ],
      ),
    );
  }
}

//* Esta classe constrói a área para o utilizador escrever o que deseja pesquisar

class BarraDaPesquisa extends StatelessWidget {
  const BarraDaPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0.0, 16, 0.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          //* Cor campo de pesquisa
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),

          //* Borda
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          child: Row(
            children: const [
              //* Lupa - ícone
              Icon(
                CupertinoIcons.search,
                color: Colors.blue,
              ),

              //* Area para escrever
              Expanded(
                child: CupertinoTextField(
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                  cursorColor: Color.fromRGBO(0, 122, 255, 1),
                  decoration: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductRowItem extends StatelessWidget {
  const ProductRowItem({
    required this.livro,
    required this.lastItem,
    Key? key,
  }) : super(key: key);

  final Livro livro;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          //** Redireciona o utilizador para a página de detalhes do livro */
          builder: (context) => LivroDetalhado(
            livro: livro,
          ),
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
              child: Image.asset(
                livro.titulo,
                fit: BoxFit.cover,
                width: 76,
                height: 76,
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
                      livro.autor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
