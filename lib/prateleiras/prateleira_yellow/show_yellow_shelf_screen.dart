// Prateleiras da Biblioteca organizadas por classes e cores
import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:flutter/material.dart';

import 'call_attributes_yellow_shelf.dart';
import 'organize__books_yellow_shelf.dart';

class PrateleirasBiblioteca extends StatelessWidget {
  const PrateleirasBiblioteca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            padding: const EdgeInsets.only(left: 26.0),
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: livrosClasseYellow.map((recent) {
                  int index = livrosClasseYellow.indexOf(recent);
                  return CartoesYellowBooks(recent, index: index);
                }).toList(),
              ),
            ),
            // TERMINA Classe 0
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: livrosClasseYellow.map((recent) {
                  int index = livrosClasseYellow.indexOf(recent);
                  return CartoesYellowBooks(recent, index: index);
                }).toList(),
              ),
            ),
            // TERMINA Classe 0
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: livrosClasseYellow.map((recent) {
                  int index = livrosClasseYellow.indexOf(recent);
                  return CartoesYellowBooks(recent, index: index);
                }).toList(),
              ),
            ),
            // TERMINA Classe 0
          ),
        ],
      ),
    );
  }
}
