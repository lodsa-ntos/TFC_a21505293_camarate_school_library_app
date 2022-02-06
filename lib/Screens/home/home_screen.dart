// ignore_for_file: unused_local_variable

import 'package:camarate_school_library/Screens/Pesquisa/pesquisa_screen.dart';
import 'package:camarate_school_library/Utils/cores.dart';
import 'package:flutter/material.dart';

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

          // --> MOSTRAR AS LISTAS DOS LIVROS NO ECRÃ <--
          Expanded(
            flex: 3,
            child: SizedBox(
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

                    // --> LIVROS REQUISITADOS <--

                    SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        height: 250.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Center(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const <Widget>[
                                Text('<vazio>'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // --> TERMINA SECÇÃO LIVROS REQUISITADOS <--

                    const SizedBox(
                      height: 12,
                    ),

                    // --> PRATELEIRAS <--
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

                    // --> INICIO DA LISTA AMARELA <--

                    const SizedBox(
                      height: 18.0,
                    ),

                    // --> TERMINA SECÇÃO LISTA AMARELA <--
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
