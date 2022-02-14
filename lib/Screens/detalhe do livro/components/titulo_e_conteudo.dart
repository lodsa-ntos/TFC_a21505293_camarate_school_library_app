// Titulo , ISBN, Editora e disponibilidade do Livro

import 'package:flutter/material.dart';

import '../livro_detalhado.dart';

class TituloEConteudos extends StatelessWidget {
  final BodyDaPaginaLivroDetalhado widget;
  const TituloEConteudos({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 0, bottom: 55),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xfff8f8f8),
            Colors.white,
          ],
        ),

        // Linha horizontal por de trás do livro
        border: Border(
          bottom: BorderSide(
            color: Color(0xfff0f0f0),
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                widget.livro.titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff333333),
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
                softWrap: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 5),
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                "ISBN: " + widget.livro.isbn,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                ),
                softWrap: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 5),
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                "Editora: " + widget.livro.editora,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                ),
                softWrap: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 25),
              width: MediaQuery.of(context).size.width / 2,
              // Se a disponibilidade for true, mostra Diponível senão Esgotado
              child: widget.livro.isDisponivel
                  ? const Text(
                      'Diponível',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 16.0,
                        fontFamily: 'Montserrat',
                      ),
                      softWrap: true,
                    )
                  : const Text(
                      'Requisitado',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 16.0,
                        fontFamily: 'Montserrat',
                      ),
                      softWrap: true,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
