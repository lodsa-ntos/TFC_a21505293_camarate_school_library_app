// Autor do Livro
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../livro_detalhado.dart';

class AutorDoLivro extends StatelessWidget {
  const AutorDoLivro({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final BodyDaPaginaLivroDetalhado widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
          bottom: 0,
        ),
        width: MediaQuery.of(context).size.width / 2,
        height: 110,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 35,
                        width: 35,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            widget.livro.imagemAutor,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.livro.autor,
                        style: GoogleFonts.catamaran(
                          textStyle: const TextStyle(
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
