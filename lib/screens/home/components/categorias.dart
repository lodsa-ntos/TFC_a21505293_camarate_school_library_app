import 'package:flutter/material.dart';

class Categoria extends StatelessWidget {
  final String titulo;
  final Function() verMais;
  final Color cor;

  const Categoria({
    Key? key,
    required this.titulo,
    required this.verMais,
    required this.cor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TituloCategoria(texto: titulo),
          if (cor == Colors.black) ...[
            ElevatedButton(
              onPressed: verMais,
              child: const Text(
                "Ver mais",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: cor, shape: StadiumBorder()),
            ),
          ] else ...[
            ElevatedButton(
              onPressed: verMais,
              child: const Text(
                "Ver mais",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: cor, shape: StadiumBorder()),
            ),
          ],
        ],
      ),
    );
  }
}

class TituloCategoria extends StatelessWidget {
  final String texto;

  const TituloCategoria({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            texto,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
