// ignore: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          AreaDaPesquisa()
        ],
      ),
    );
  }
}

//* Esta classe constrói a área para o utilizador escrever o que deseja pesquisar

class AreaDaPesquisa extends StatelessWidget {
  const AreaDaPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0.0, 16, 0.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 8,
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.search,
                color: Colors.blue,
              ),
              const Expanded(
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
              GestureDetector(
                child: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
