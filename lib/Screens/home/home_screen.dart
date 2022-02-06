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
        ],
      ),
    );
  }
}
