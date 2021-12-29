import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:camarate_school_library/livros_emprestados_user/borrowed.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

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
                  .cover, // ajuda a ficar do mesmo tamanho (ampliando a imagem)
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
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //Data de entrega
            const Text(
              'Data de entrega:',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              emprestado.dataEntrega,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
