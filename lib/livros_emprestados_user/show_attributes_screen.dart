// Livros Requisitados e devolvidos pelo utilizador
import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:flutter/cupertino.dart';
import 'call_attributes.dart';
import 'organize_attributes.dart';

class LivrosRequisitados extends StatelessWidget {
  const LivrosRequisitados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Text(
              'Livros requisitados',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: darkColor,
                  fontFamily: 'Poppins'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: livrosEmprestados.map((recent) {
                  int index = livrosEmprestados.indexOf(recent);
                  return CartoesLivrosEmprestados(recent, index: index);
                }).toList(),
              ),
            ),
          ),
          // Lista de lisvros requisitados
        ],
      ),
    );
  }
}
