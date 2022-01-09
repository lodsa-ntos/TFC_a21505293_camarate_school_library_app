import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:flutter/material.dart';

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
