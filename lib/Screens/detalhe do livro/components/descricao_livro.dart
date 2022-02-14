// Descricao para o Livro
import 'package:flutter/material.dart';

import '../livro_detalhado.dart';

class DescricaoDoLivro extends StatefulWidget {
  const DescricaoDoLivro({
    Key? key,
    required this.widget,
    required this.texto,
  }) : super(key: key);

  final BodyDaPaginaLivroDetalhado widget;
  final String texto;

  @override
  State<DescricaoDoLivro> createState() => _DescricaoDoLivroState();
}

class _DescricaoDoLivroState extends State<DescricaoDoLivro> {
  late String primeiraMetadeDoTexto;

  late String segundaMetadeDoTexto;

  bool isTextoAberto = true;

  //Comportamento para o texto da descrição
  @override
  void initState() {
    super.initState();

    if (widget.widget.livro.descricao.length > 300) {
      primeiraMetadeDoTexto = widget.texto.substring(0, 300);
      segundaMetadeDoTexto = widget.texto.substring(300, widget.texto.length);
    } else {
      primeiraMetadeDoTexto = widget.texto;
      segundaMetadeDoTexto = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 27),
            width: MediaQuery.of(context).size.width / 2,
            child: const Text(
              'Descrição',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
                fontSize: 18,
                fontFamily: 'Montserrat',
              ),
              softWrap: true,
            ),
          ),
        ),
        const Divider(
          height: 20,
          thickness: 4,
          indent: 27,
          endIndent: 250,
          color: Colors.black,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 15),
          child: segundaMetadeDoTexto.isEmpty
              ? Text(
                  (isTextoAberto
                          ? (primeiraMetadeDoTexto)
                          : (primeiraMetadeDoTexto + segundaMetadeDoTexto))
                      .replaceAll(r'\n', '\n')
                      .replaceAll(r'\r', '')
                      .replaceAll(r"\'", "'"),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF171717),
                    letterSpacing: 1.5,
                    height: 2,
                  ),
                  textAlign: TextAlign.justify,
                )
              : Column(
                  children: <Widget>[
                    Text(
                      (isTextoAberto
                              ? (primeiraMetadeDoTexto + '...')
                              : (primeiraMetadeDoTexto + segundaMetadeDoTexto))
                          .replaceAll(r'\n', '\n\n')
                          .replaceAll(r'\r', '')
                          .replaceAll(r"\'", "'"),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF171717),
                        letterSpacing: 1.5,
                        height: 2,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            isTextoAberto ? 'mostrar mais' : 'mostrar menos',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          isTextoAberto = !isTextoAberto;
                        });
                      },
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
