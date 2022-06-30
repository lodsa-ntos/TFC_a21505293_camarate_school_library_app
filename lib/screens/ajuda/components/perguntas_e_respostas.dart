import 'package:flutter/material.dart';

import '../../../models/ajuda.dart';

class PerguntasERespostas extends StatelessWidget {
  const PerguntasERespostas(this.ajuda);
  final Ajuda ajuda;

  @override
  Widget build(BuildContext context) {
    return _construirPerguntasERespostas(ajuda);
  }

  // Esta função cria recursivamente as linhas da lista
  Widget _construirPerguntasERespostas(Ajuda ajuda) {
    if (ajuda.listaDeAjudas.isEmpty) {
      return ListTile(
        title: Text(ajuda.titulo),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Ajuda>(ajuda),
      title: Text(ajuda.titulo),
      children: ajuda.listaDeAjudas
          .map<Widget>(_construirPerguntasERespostas)
          .toList(),
    );
  }
}
