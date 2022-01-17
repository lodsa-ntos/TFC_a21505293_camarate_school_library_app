// ignore_for_file: unused_local_variable

import 'package:camarate_school_library/Home/Prateleiras/Lista_amarela/Pagina_detalhes_do%20livro/pagina_detalhes_livro.dart';
import 'package:flutter/material.dart';
import 'package:camarate_school_library/Home/Pesquisa/pesquisa.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Guias_de_estilos/cores.dart';
import 'Pesquisa/pesquisa.dart';
import 'Prateleiras/Lista_amarela/Dados/dados_lista_amarela.dart';

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

                  // --> LIVROS REQUISITADOS <--

                  SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      height: 80.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            Text('Ainda sem livros requisitados...'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // --> TERMINA SECÇÃO LIVROS REQUISITADOS <--

                  const SizedBox(
                    height: 50,
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
                  tituloDaClasseAmarela(),

                  const SizedBox(
                    height: 18.0,
                  ),

                  SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      height: 350.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            livrosListaAmarela(dadosListaAmarela[0]),
                            livrosListaAmarela(dadosListaAmarela[1]),
                            livrosListaAmarela(dadosListaAmarela[2]),
                            livrosListaAmarela(dadosListaAmarela[3]),
                            livrosListaAmarela(dadosListaAmarela[4]),
                            livrosListaAmarela(dadosListaAmarela[5]),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // --> TERMINA SECÇÃO LISTA AMARELA <--
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FUNÇÃO QUE CARREGA A LISTA DE LIVROS DA SECÇAO AMARELA
  Widget livrosListaAmarela(DadosListaAmarela dadosListaAmarela) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaginaDetalhesLivro(
              livros: dadosListaAmarela,
            ),
          ),
        );
      },
      child: Container(
        width: 122.0,
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 121.66,
              height: 190.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(dadosListaAmarela.imagem),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              dadosListaAmarela.titulo,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              dadosListaAmarela.autor,
              style: GoogleFonts.catamaran(
                textStyle: const TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            if (dadosListaAmarela.disponibilidade == "Disponível") ...[
              Text(
                dadosListaAmarela.disponibilidade,
                style: GoogleFonts.catamaran(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ] else
              Text(
                dadosListaAmarela.disponibilidade,
                style: GoogleFonts.catamaran(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
          ],
        ),
      ),
    );
  }

// Apenas o titulo da secção amarela
  Widget tituloDaClasseAmarela() {
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
}
