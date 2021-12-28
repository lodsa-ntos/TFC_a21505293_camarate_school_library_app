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
    return Container(
      width: 238,
      height: 145,
      margin: EdgeInsets.only(
        right: 20,
        bottom: 10,
        top: 10,
        left: index == 0 ? 30.0 : 0,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            spreadRadius: 2,
            color: Colors.blue.shade300,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(emprestado.image),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Titulo
              emprestado.title.text.xl
                  .color(MyThemeColor.darkBluishColor)
                  .bold
                  .make(),
              //autor
              //emprestado.autor.text.xl.lg.color(Colors.black).make(),
              const SizedBox(width: 44),
              const SizedBox(width: 44),
              const SizedBox(width: 44),
              //Data de entrega
              const Text(
                'Entregue em:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
              //emprestado.dataEntrega.text.pink100.color(Colors.black).bold.make(),
            ],
          ),
        ],
      ),
    );
  }
}
