import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'borrowed_books.dart';

Widget prateleiraEmprestados(LivrosEmprestados livrosEmprestados) {
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
                livrosEmprestados.imagem,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          livrosEmprestados.titulo,
          style: GoogleFonts.catamaran(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          livrosEmprestados.dataEntrega,
          style: GoogleFonts.catamaran(fontSize: 16.0, color: Colors.grey),
        ),
      ],
    ),
  );
}
