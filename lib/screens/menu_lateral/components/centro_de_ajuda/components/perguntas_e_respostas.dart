import 'package:camarate_school_library/Models/ajuda.dart';
import 'package:flutter/material.dart';

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
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 33),
        child: ListTile(
          title: Text(
            ajuda.titulo,
            style: TextStyle(fontFamily: 'Carmen', height: 1.5),
          ),
        ),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Ajuda>(ajuda),
      title: Container(
        margin: EdgeInsets.only(top: 15),
        child: Text(
          ajuda.titulo,
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w600,
            color: Color(0xff4285f4),
          ),
        ),
      ),
      children: ajuda.listaDeAjudas
          .map<Widget>(_construirPerguntasERespostas)
          .toList(),
    );
  }
}
