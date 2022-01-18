// ignore_for_file: deprecated_member_use

import 'package:camarate_school_library/Home/Layout/layout_pagina_utilizador.dart';
import 'package:camarate_school_library/Home/Prateleiras/Lista_amarela/Dados/dados_lista_amarela.dart';
import 'package:camarate_school_library/Home/Prateleiras/Lista_amarela/Dados/dados_livros_requisitados.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class PaginaDetalhesLivro extends StatelessWidget {
  const PaginaDetalhesLivro({
    Key? key,
    required this.livros,
  }) : super(key: key);

  final DadosListaAmarela livros;

  @override
  Widget build(BuildContext context) {
    const isRequisitado = false;

    return Scaffold(
// ---> BOTÃO REQUISITAR <---
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: FlatButton(
          color: const Color.fromRGBO(18, 157, 158, 1),
          onPressed: () {
            for (int i = 0; i < dadosListaAmarela.length; i++) {
              if (dadosListaAmarela[i].disponibilidade == "Disponível") {
                [
                  // O livro é adicionado a lista dos livros requisitados...

                  // Dizemos que o livro está requisitado...
                  livros.livroRequisitado = true,

                  // A disponibilidade do livro passa a ser "Esgotado"...
                  Text(
                    livros.disponibilidade = "Esgotado",
                    style: GoogleFonts.catamaran(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ];
                print('O livro requisitado com sucesso');
              } else {
                print('Erro: a requisicao falhou');
              }
            }
          },
          child: Text(
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
                                livros.imagem,
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
                        livros.titulo,
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
                            livros.autor,
                            style: GoogleFonts.catamaran(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
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
                          if (livros.disponibilidade == "Disponível") ...[
                            Text(
                              livros.disponibilidade,
                              style: GoogleFonts.catamaran(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ] else
                            Text(
                              livros.disponibilidade,
                              style: GoogleFonts.catamaran(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
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
                        livros.descricao,
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
