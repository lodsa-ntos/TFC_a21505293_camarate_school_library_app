import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListaLivroRequisitado extends StatelessWidget {
  final Livro livros;

  const ListaLivroRequisitado({Key? key, required this.livros})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataDeHoje = DateTime.now();
    var formato = DateFormat('dd-MM-yyyy');
    String data = formato.format(dataDeHoje);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 111.0,
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 121.66,
              height: 165.5,
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
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
