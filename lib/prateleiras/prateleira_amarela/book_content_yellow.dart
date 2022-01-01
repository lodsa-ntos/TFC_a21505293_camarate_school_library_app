import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:camarate_school_library/prateleiras/prateleira_amarela/variables_show_book.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Conteúdos do Livro a serem apresentados no ecrã
Widget prateleiraAmarela(DadosListaAmarela livrosNasPrateleiras) {
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
                livrosNasPrateleiras.imagem,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          livrosNasPrateleiras.tituloLivro,
          style: GoogleFonts.catamaran(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          livrosNasPrateleiras.autor,
          style: GoogleFonts.catamaran(fontSize: 16.0, color: Colors.grey),
        ),
        if (livrosNasPrateleiras.disponibilidade == "Disponível") ...[
          Text(
            livrosNasPrateleiras.disponibilidade,
            style: GoogleFonts.catamaran(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
        ] else
          Text(
            livrosNasPrateleiras.disponibilidade,
            style: GoogleFonts.catamaran(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700),
          ),
      ],
    ),
  );
}

Widget tituloDaClasse() {
  return Column(
    children: [
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
    ],
  );
}
