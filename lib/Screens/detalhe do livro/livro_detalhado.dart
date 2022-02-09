// ignore_for_file: deprecated_member_use

import 'package:camarate_school_library/Layout/layout_pagina_principal.dart';
import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LivroDetalhado extends StatefulWidget {
  const LivroDetalhado({
    Key? key,
    required this.livro,
  }) : super(key: key);

  final Livro livro;

  @override
  State<LivroDetalhado> createState() => _LivroDetalhadoState();
}

class _LivroDetalhadoState extends State<LivroDetalhado> {
  bool isRequisitado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// ---> BOTÃO REQUISITAR <---
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: FlatButton(
          color: const Color.fromRGBO(18, 157, 158, 1),
          onPressed: () {
            if (widget.livro.disponibilidade == "Disponível") {
              setState(() {
                isRequisitado = true;
              });

              Future.delayed(
                // Processo que depois será mudado para a confirmação do administrador
                const Duration(seconds: 3),
                () {
                  setState(
                    () {
                      isRequisitado = false;
                    },
                  );

                  // Mostra mensagem ao utilizador que a requisicao foi efetuado com sucesso
                  showDialog<String>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 16,
                        title: const Text(
                          'Pedido efetuado com sucesso',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        content: const Text(
                          // ignore: prefer_adjacent_string_concatenation
                          "Confirme e dirigi-se a biblioteca para fazer o levantamento do seu livro. \n" +
                              "O prazo de devolução é de 10 dias.\n\n" +
                              "Obrigado!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF171717),
                            height: 2,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                // A disponibilidade do livro passa a estar "Esgotado"...
                                Text(
                                  widget.livro.disponibilidade = 'Esgotado',
                                  style: GoogleFonts.catamaran(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade700,
                                  ),
                                );
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LayoutPaginaPrincipal(),
                                ),
                              );
                            },
                            child: const Text(
                              'Confirmar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(18, 157, 158, 1),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );

              // Se o utilizador tentar requisitar um livro que esteja esgotado
            } else if (widget.livro.disponibilidade == "Esgotado") {
              // É apresentado a mensagem de pedido recusado
              showDialog<String>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 16,
                    title: const Text(
                      'Pedido recusado',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    content: const Text(
                      // ignore: prefer_adjacent_string_concatenation
                      "O livro encontra-se esgotado.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF171717),
                        height: 2,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(18, 157, 158, 1),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              // ignore: avoid_print
              print(
                  'Erro: a requisicao falhou, porque o livro encontra-se esgotado');
            }
          },
          child: isRequisitado
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                )
              : Text(
                  'Requisitar',
                  style: GoogleFonts.catamaran(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // ---> TERMINA EDIÇÃO BOTÃO REQUISITAR <---

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            // ação voltar para trás
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              // seta voltar para trás
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black87,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: BodyDaPaginaLivroDetalhado(livro: widget.livro),
    );
  }
}

class BodyDaPaginaLivroDetalhado extends StatefulWidget {
  final Livro livro;
  const BodyDaPaginaLivroDetalhado({
    Key? key,
    required this.livro,
  }) : super(key: key);

  @override
  State<BodyDaPaginaLivroDetalhado> createState() =>
      _BodyDaPaginaLivroDetalhadoState();
}

class _BodyDaPaginaLivroDetalhadoState
    extends State<BodyDaPaginaLivroDetalhado> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  TituloDoLivro(widget: widget), // Titulo , ISBN, Editora...
                  AutorDoLivro(widget: widget), // Nome autor
                  DescricaoDoLivro(widget: widget), // Descricão Do Livro
                ],
              ),

              // IMAGEM CAPA DO LIVRO
              Positioned(
                left: 25,
                top: 10,
                child: SizedBox(
                  height: 260,
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.livro.imagemCapa,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TituloDoLivro extends StatelessWidget {
  final BodyDaPaginaLivroDetalhado widget;
  const TituloDoLivro({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5, bottom: 55),
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
              child: Text(
                widget.livro.disponibilidade,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
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

class AutorDoLivro extends StatelessWidget {
  const AutorDoLivro({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final BodyDaPaginaLivroDetalhado widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
          bottom: 0,
        ),
        width: MediaQuery.of(context).size.width / 2,
        height: 110,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 35,
                        width: 35,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            widget.livro.imagemAutor,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.livro.autor,
                        style: GoogleFonts.catamaran(
                          textStyle: const TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DescricaoDoLivro extends StatelessWidget {
  const DescricaoDoLivro({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final BodyDaPaginaLivroDetalhado widget;

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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 30),
          child: Text(
            widget.livro.descricao,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF171717),
              letterSpacing: 1.5,
              height: 2,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
