import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:camarate_school_library/livros_emprestados_user/borrowed.dart';
import 'package:camarate_school_library/livros_emprestados_user/card_borrowed.dart';
import 'package:camarate_school_library/prateleiras/beige_class.dart';
import 'package:camarate_school_library/prateleiras/detalhes/card_books_beige.dart';
import 'package:camarate_school_library/prateleiras/detalhes/card_books_yellow.dart';
import 'package:camarate_school_library/prateleiras/yellow_class.dart';
import 'package:flutter/material.dart';
import 'package:camarate_school_library/ferramentas/search_screen.dart';

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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              // Ação para o icon do menu lateral
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          //Espaçamento entre icone menu e título Livros requisitados
          const SizedBox(
            height: 10,
          ),

          // --> Lista dos livros <--
          LivrosRequisitados(),
          const PrateleirasBiblioteca(),
          const Sobe(),
        ],
      ),
    );
  }
}

// Livros Requisitados e devolvidos pelo utilizador
class LivrosRequisitados extends StatelessWidget {
  LivrosRequisitados({Key? key}) : super(key: key);

// ignore: unnecessary_new
  final ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Livros requisitados',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: darkColor,
                  fontFamily: 'Poppins'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // Lista de lisvros requisitados
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: livrosEmprestados.map((recent) {
                int index = livrosEmprestados.indexOf(recent);
                return CartoesLivrosEmprestados(recent, index: index);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Prateleiras da Biblioteca organizadas por classes e cores
class PrateleirasBiblioteca extends StatelessWidget {
  const PrateleirasBiblioteca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Prateleiras',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: darkColor,
                  fontFamily: 'Poppins'),
            ),
          ),
          // Classe 0 - Generabilidade.Dicionários.Enciclopédias.Informática
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(left: 30.0),
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
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: livrosClasseYellow.map((recent) {
                int index = livrosClasseYellow.indexOf(recent);
                return CartoesYellowBooks(recent, index: index);
              }).toList(),
            ),
          ),

          // TERMINA Classe 0

          // Classe 1 - Filosofia e Psicologia
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: const [
                // Circulo das classes
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  minRadius: 15,
                ),
                Padding(
                  // espaço entre o circulo e o título da classe
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Filosofia . Psicologia',
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
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: livrosClasseBeige.map((recent) {
                int index = livrosClasseBeige.indexOf(recent);
                return CartoesBeigeBooks(recent, index: index);
              }).toList(),
            ),
          ),

          // TERMINA Classe 1
        ],
      ),
    );
  }
}

class Sobe extends StatelessWidget {
  const Sobe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(resizeToAvoidBottomInset: false);
  }
}
