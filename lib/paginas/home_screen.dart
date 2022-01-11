// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:camarate_school_library/prateleiras/prateleira_amarela/ecra_de_detalhes/book_details.dart';
import 'package:camarate_school_library/prateleiras/prateleira_amarela/variables_show_book.dart';
import 'package:camarate_school_library/prateleiras/prateleira_amarela/book_content_yellow.dart';
import 'package:camarate_school_library/requisitados/borrowed_books.dart';
import 'package:camarate_school_library/requisitados/borrowed_shelf.dart';
import 'package:flutter/material.dart';
import 'package:camarate_school_library/ferramentas/search_screen.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xDeslocamento = 0;
  double yDeslocamento = 0;
  double fatorDeEscala = 1;

  bool isMenuAberto = false;

  @override
  void initState() {
    super.initState();
    carregarDadosPrateleira();
  }

  // sempre que abrir o ecrã de pesquisa carrega a minha lista inicial de livros
  //do ficheiro .json...
  carregarDadosPrateleira() async {
    final prateleirasJSON =
        await rootBundle.loadString("assets/files/livros_prateleiras.json");
    var dadosDecodificados = jsonDecode(prateleirasJSON);
    var informacoesDoLivro = dadosDecodificados["prateleira"];

    DadosListaAmarela.livrosNasPrateleiras = List.from(informacoesDoLivro)
        .map<PrateleirasDaBiblioteca>((livrosNasPrateleiras) =>
            PrateleirasDaBiblioteca.fromMap(livrosNasPrateleiras))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // animação para a página home quando clicar no ícone do menu lateral
      transform: Matrix4.translationValues(xDeslocamento, yDeslocamento, 0)
        ..scale(fatorDeEscala)
        ..rotateY(isMenuAberto ? -0.5 : 0),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMenuAberto ? 40 : 0.0),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),

          // Este container contém os icones do menu lateral e de pesquisa
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              // Espaçamento entre os icones
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Ação para o icon do menu lateral
              children: [
                isMenuAberto
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            xDeslocamento = 0;
                            yDeslocamento = 0;
                            fatorDeEscala = 1;
                            isMenuAberto = false;
                          });
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            xDeslocamento = 230;
                            yDeslocamento = 150;
                            fatorDeEscala = 0.6;
                            isMenuAberto = true;
                          });
                        },
                      ),

                // Ação para o icon da pesquisa
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PesquisaScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(
            height: 715,
            child: SingleChildScrollView(
              //scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 13.0, right: 189.0),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.0),
                      child: Text(
                        'Livros Requisitados',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: darkColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),
                  // Lista de lisvros requisitados
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // falta chamar a lista ....
                    child: SizedBox(
                      width: 355,
                      height: 85.0,
                      child: Text('Ainda sem livros requisitados...'),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  Container(
                    padding: const EdgeInsets.only(right: 189.0),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.0),
                      child: Text(
                        'Prateleiras',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: darkColor,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),

                  // --> MOSTRAR AS LISTAS DOS LIVROS NO ECRÃ <--
                  tituloDaClasse(),

                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '',
                        ),
                        SizedBox(
                          width: 355,
                          height: 350.0,
                          child: ListasNaPrateleira(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --> Classe para chamar o index do ficheiro JSON
class ListasNaPrateleira extends StatelessWidget {
  const ListasNaPrateleira({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // ignore: prefer_const_constructors
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: DadosListaAmarela.livrosNasPrateleiras.length,
      itemBuilder: (context, index) {
        if (DadosListaAmarela.livrosNasPrateleiras[0] != null) {
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BookDetailScreen(),
                ),
              );
            },
          );
        }
        final prats = DadosListaAmarela.livrosNasPrateleiras[2];
        return DadosParaAPrateleira(elementoNaPrateleira: prats);
      },
    );
  }
}

// Classe para definir o conteúdo dos livros
// ignore: must_be_immutable
class DadosParaAPrateleira extends StatelessWidget {
  PrateleirasDaBiblioteca elementoNaPrateleira;

  DadosParaAPrateleira({
    Key? key,
    required this.elementoNaPrateleira,
    // ignore: unnecessary_null_comparison
  })  : assert(elementoNaPrateleira != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122.0,
      margin: const EdgeInsets.only(right: 12.0),
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
                image: NetworkImage(
                  elementoNaPrateleira.imagem,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            elementoNaPrateleira.titulo,
            style: GoogleFonts.catamaran(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            elementoNaPrateleira.autor,
            style: GoogleFonts.catamaran(fontSize: 16.0, color: Colors.grey),
          ),
          if (elementoNaPrateleira.disponibilidade == "Disponível") ...[
            Text(
              elementoNaPrateleira.disponibilidade,
              style: GoogleFonts.catamaran(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ] else
            Text(
              elementoNaPrateleira.disponibilidade,
              style: GoogleFonts.catamaran(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
        ],
      ),
    );
  }
}
