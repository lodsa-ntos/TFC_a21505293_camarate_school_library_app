// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/Pesquisa/pesquisa_screen.dart';
import 'package:camarate_school_library/Screens/lista%20de%20livros/lista_de_livros.dart';
import 'package:camarate_school_library/Screens/lista%20de%20livros/o_meu_livro_requisitado.dart';
import 'package:camarate_school_library/Utils/cores.dart';
import 'package:flutter/material.dart';

final livros = gerarLivrosAleatorios();

final key = GlobalKey<AnimatedListState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xDeslocamento = 0;
  double yDeslocamento = 0;
  double fatorDeEscala = 1.0;

  bool isMenuAberto = false;

  final espacamentoVertical = const SizedBox(
    height: 14,
  );

  final tituloLivrosRequisitados = Container(
    padding: const EdgeInsets.symmetric(horizontal: 26.0),
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
  );

  final areaVazia = CustomPaint(
    child: Container(
      margin: const EdgeInsets.only(
        left: 26.0,
        right: 26.0,
      ),
      color: Colors.white,
      child: const Center(
        child: Text('<vazio>'),
      ),
    ),
  );

  final tituloPrateleiras = Container(
    padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 30),
    child: const Text(
      'Prateleiras',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: darkColor,
      ),
    ),
  );

  final tituloSeccaoAmarela = Container(
    padding: const EdgeInsets.only(left: 27.0),
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
  );

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
          // Altura dos icones
          const SizedBox(
            height: 35,
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
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Espaço
                  espacamentoVertical,
                  tituloLivrosRequisitados,

                  // Espaço
                  espacamentoVertical,

                  // Área para livros requisitados .--> por enquanto ainda vazia
                  SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      height: 285.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // Por enquanto atualizar a pagina
                            if (livros[0].isRequisitado == true) ...[
                              OMeuLivroRequisitado(livros: livros[0]),
                            ] else ...[
                              const Text(
                                '<vazio>',
                                textAlign: TextAlign.center,
                              ),
                            ],
                            if (livros[1].isRequisitado == true) ...[
                              OMeuLivroRequisitado(livros: livros[1]),
                            ] else ...[
                              const Text(
                                '',
                                textAlign: TextAlign.center,
                              ),
                            ],
                            if (livros[2].isRequisitado == true) ...[
                              OMeuLivroRequisitado(livros: livros[2]),
                            ] else ...[
                              const Text(
                                '',
                                textAlign: TextAlign.center,
                              ),
                            ],
                            if (livros[3].isRequisitado == true) ...[
                              OMeuLivroRequisitado(livros: livros[3]),
                            ] else ...[
                              const Text(
                                '',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  //const Divider(),
                  // Titulos
                  tituloPrateleiras,
                  tituloSeccaoAmarela,

                  // Espaço
                  espacamentoVertical,
                  SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      height: 350.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: ListView.builder(
                          // carregar até ao último indice
                          itemCount: livros.length,
                          scrollDirection: Axis.horizontal,
                          // comportamento para que a ListView só ocupe o espaço de que necessita
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              ListaDeLivros(livros: livros[index]),
                        ),
                      ),
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
