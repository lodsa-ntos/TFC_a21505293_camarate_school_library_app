// ignore_for_file: deprecated_member_use
import 'package:camarate_school_library/Layout/layout_pagina_principal.dart';
import 'package:camarate_school_library/Models/livro.dart';
import 'package:cool_alert/cool_alert.dart';
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
      appBar: PreferredSize(
        // Altura do livro
        preferredSize: const Size.fromHeight(55),
        child: Padding(
          // Altura do icone para voltar para trás
          padding: const EdgeInsets.only(left: 2, top: 12),
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
      // Mostra todo o conteudo da página de detalhes
      body: BodyDaPaginaLivroDetalhado(livro: widget.livro),
      // Botao para requisitar o Livro
      bottomNavigationBar: BotaoRequisitar(livro: widget.livro),
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

// Titulo , ISBN, Editora e disponibilidade do Livro
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
              child: widget.livro.disponibilidade
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
                      'Esgotado',
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

// Autor do Livro
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

// Descricao para o Livro
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
        const Divider(
          height: 20,
          thickness: 4,
          indent: 27,
          endIndent: 250,
          color: Colors.black,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 15),
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

// Botao para Requisitar
class BotaoRequisitar extends StatefulWidget {
  const BotaoRequisitar({
    Key? key,
    required this.livro,
  }) : super(key: key);

  final Livro livro;

  @override
  _BotaoRequisitarState createState() => _BotaoRequisitarState();
}

class _BotaoRequisitarState extends State<BotaoRequisitar> {
  List<Livro> livroRequisitado = [];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
        height: 49,
        color: Colors.transparent,
        child: ElevatedButton(
          child: Text(
            'Requisitar',
            style: GoogleFonts.catamaran(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // <-- Radius
            ),
          ),

          // Se o livro estiver disponível o botao vai estar habilitado
          onPressed: widget.livro.disponibilidade
              ? () {
                  setState(() {
                    widget.livro.disponibilidade = false;
                    // o livro fica requisitado
                    widget.livro.isRequisitado = true;
                    // Redireciona o utilizador para a página principal
                    Navigator.pop(context);
                    // Adiciona o livro na lista de requisitados
                    addNaListaLivrosRequisitados;
                  });
                }
              // senão estiver disponível, o botao vai estar desabilitado
              : null,
        ),
      ),
    );
  }

  // A pensar...
  addNaListaLivrosRequisitados() async {
    final dados = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LayoutPaginaPrincipal(), // alterar
      ),
    );

    livroRequisitado.add(dados); // ação imcompleta

    ///
  }
}
