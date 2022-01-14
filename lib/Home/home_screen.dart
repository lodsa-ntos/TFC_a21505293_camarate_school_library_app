// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:camarate_school_library/Home/guia_de_estilos/cores.dart';
import 'package:camarate_school_library/prateleiras/prateleira_amarela/variables_show_book.dart';
import 'package:flutter/material.dart';
import 'package:camarate_school_library/Home/Utilidades/pesquisa.dart';
import 'package:flutter/services.dart';

import 'Utilidades/pesquisa.dart';
import 'guia_de_estilos/cores.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xDeslocamento = 0;
  double yDeslocamento = 0;
  double fatorDeEscala = 1.0;

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
      duration: const Duration(milliseconds: 300),

      // animação para a página home quando clicar no ícone do menu lateral
      transform: Matrix4.translationValues(xDeslocamento, yDeslocamento, 0)
        ..scale(fatorDeEscala)
        ..rotateY(isMenuAberto ? -0.5 : 0),

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

              children: [
                // Ação para o icon do menu lateral
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
                      MaterialPageRoute(builder: (context) => Pesquisa()),
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
                          // lista
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

// Apenas o titulo da secção amarela
Widget tituloDaClasse() {
  return Column(
    children: [
      const SizedBox(
        height: 15,
      ),
      Container(
        padding: const EdgeInsets.only(left: 28.0),
        child: Row(
          children: const [
            // Circulo das classes
            CircleAvatar(
              backgroundColor: Colors.yellow,
              minRadius: 15,
            ),
            Padding(
              // espaço entre o circulo e o título da classe
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Generabilidade.Dicionários.\nEnciclopédias.Informática',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: darkColor,
                    fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
