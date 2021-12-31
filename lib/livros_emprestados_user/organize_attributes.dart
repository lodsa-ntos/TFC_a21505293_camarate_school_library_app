import 'package:camarate_school_library/livros_emprestados_user/call_attributes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartoesLivrosEmprestados extends StatelessWidget {
  const CartoesLivrosEmprestados(
    this.emprestado, {
    Key? key,
    required this.index,
  }) : super(key: key);

  final Emprestados emprestado;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 95,
          height: 135,
          margin: const EdgeInsets.only(
            right: 10,
            bottom: 10,
            top: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(emprestado.image),
              fit: BoxFit
                  .fitWidth, // ajuda a ficar do mesmo tamanho (ampliando a imagem)
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                emprestado.title,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: GoogleFonts.catamaran(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //Data de entrega
            Text(
              'Data de entrega:',
              style: GoogleFonts.catamaran(
                fontSize: 12,
              ),
            ),
            Text(
              emprestado.dataEntrega,
              style: GoogleFonts.catamaran(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
