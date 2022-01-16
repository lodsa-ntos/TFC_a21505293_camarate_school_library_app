import 'package:flutter/cupertino.dart';

import 'Dados/dados_lista_amarela.dart';

Widget livrosListaAmarela(DadosListaAmarela dadosListaAmarela) {
  return Container(
    width: 122.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 121.66,
          height: 180.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(dadosListaAmarela.imagem),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}
