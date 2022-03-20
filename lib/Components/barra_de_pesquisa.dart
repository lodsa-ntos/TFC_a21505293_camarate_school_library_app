import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarraDePesquisa extends StatelessWidget {
  const BarraDePesquisa({
    required this.controlador,
    required this.foco,
    Key? key,
  }) : super(key: key);

  final TextEditingController controlador;
  final FocusNode foco;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 7),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xffe0e0e0),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 8,
              ),
              child: Row(
                children: [
                  //* Lupa
                  const Icon(
                    CupertinoIcons.search,
                    color: Colors.blue,
                  ),

                  //* Caixa de texto
                  Expanded(
                    child: CupertinoTextField(
                      controller: controlador,
                      focusNode: foco,
                      cursorColor: Colors.black,
                      decoration: null,
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  //* X --> para apagar a palavra que foi escrita
                  GestureDetector(
                    onTap: controlador.clear,
                    child: const Icon(
                      CupertinoIcons.clear_thick_circled,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
