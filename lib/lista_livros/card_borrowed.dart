import 'package:camarate_school_library/lista_livros/borrowed.dart';
import 'package:flutter/material.dart';

class CartoesLisvrosEmprestados extends StatelessWidget {
  const CartoesLisvrosEmprestados(
    this.emprestado, {
    Key? key,
    required this.index,
  }) : super(key: key);

  final Emprestados emprestado;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 228,
      height: 150,
      margin: EdgeInsets.only(
        right: 20,
        bottom: 10,
        top: 10,
        left: index == 0 ? 30 : 0,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            spreadRadius: 2,
            color: Colors.grey.shade200,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(emprestado.image),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                emprestado.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
