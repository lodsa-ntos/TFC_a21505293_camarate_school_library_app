import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/Detalhe%20do%20livro/livro_detalhado.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListaDeLivros extends StatelessWidget {
  const ListaDeLivros({Key? key, required this.livros}) : super(key: key);

  final Livro livros;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LivroDetalhado(
              livro: livros,
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
                  image: NetworkImage(livros.imagemCapa),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              livros.titulo,
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
              livros.autor,
              style: GoogleFonts.catamaran(
                textStyle: const TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
