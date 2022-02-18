import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/Historico%20livro%20requisitado/historico.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'components/autor_do_livro.dart';
import 'components/descricao_livro.dart';
import 'components/titulo_e_conteudo.dart';
import 'components/verificar_livro_detalhado.dart';
import 'function/verificar_requisicao.dart';

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
  final chave = GlobalKey<AnimatedListState>();
  final livros = gerarLivrosAleatorios();
  Livro? livro;
  VerificarRequisico? verificarRequisico;

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
          onPressed: widget.livro.isDisponivel
              ? () {
                  setState(() {
                    widget.livro.isDisponivel = false;
                    // o livro fica requisitado
                    widget.livro.isRequisitado = true;
                    // Redireciona o utilizador para a página principal
                    if (widget.livro.isRequisitado = true) {
                      verificarRequisico?.addLivroRequisitado();
                    }
                  });
                }
              // se o livro não estiver disponível, o botao vai estar desabilitado
              : null,
        ),
      ),
    );
  }
}

// Corpo da página
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
                  TituloEConteudos(widget: widget), // Titulo , ISBN, Editora...
                  AutorDoLivro(widget: widget), // Nome autor
                  DescricaoDoLivro(
                    widget: widget,
                    texto: widget.livro.descricao,
                  ), // Descricão Do Livro
                ],
              ),

              // IMAGEM CAPA DO LIVRO
              Positioned(
                left: 25,
                top: 10,
                child: SizedBox(
                  height: 260,
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  child: Material(
                    //borderRadius: BorderRadius.circular(10),
                    elevation: 15.0,
                    shadowColor: Colors.grey.shade900,
                    child: Image.network(
                      widget.livro.imagemCapa,
                      fit: BoxFit.cover,
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
