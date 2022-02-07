// ignore_for_file: deprecated_member_use

import 'package:camarate_school_library/Layout/layout_pagina_principal.dart';
import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

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

      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blue,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: const Color.fromRGBO(18, 157, 158, 1),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 62.0),
                          width: 225.0,
                          height: 282.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.livro.imagemCapa,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, left: 25.0),
                      child: Text(
                        widget.livro.titulo,
                        style: GoogleFonts.catamaran(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, left: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "De: " + widget.livro.autor,
                            style: GoogleFonts.catamaran(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF171717),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, left: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ISBN: " + widget.livro.isbn,
                            style: GoogleFonts.catamaran(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF171717),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Editora: " + widget.livro.editora,
                            style: GoogleFonts.catamaran(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF171717),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.livro.disponibilidade == "Disponível") ...[
                            Text(
                              widget.livro.disponibilidade,
                              style: GoogleFonts.catamaran(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ] else
                            Text(
                              widget.livro.disponibilidade,
                              style: GoogleFonts.catamaran(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      height: 28.0,
                      margin: const EdgeInsets.only(top: 23.0, bottom: 20.0),
                      padding: const EdgeInsets.only(left: 27.0),
                      child: DefaultTabController(
                        length: 1,
                        child: TabBar(
                          labelPadding: const EdgeInsets.all(0),
                          indicatorPadding: const EdgeInsets.all(0),
                          isScrollable: true,
                          labelColor: Colors.black,
                          labelStyle: GoogleFonts.catamaran(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          indicator: MaterialIndicator(
                            height: 3,
                            tabPosition: TabPosition.bottom,
                          ),
                          tabs: [
                            Tab(
                              child: Container(
                                margin: const EdgeInsets.only(right: 23.0),
                                child: const Text('Descrição'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 25),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
