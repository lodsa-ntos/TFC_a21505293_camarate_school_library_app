//* Classe para montar os menus do filtro de pesquisa

import 'package:camarate_school_library/Models/livro.dart';
import 'package:flutter/material.dart';

class FiltrarPesquisa extends StatefulWidget {
  const FiltrarPesquisa({Key? key}) : super(key: key);

  @override
  State<FiltrarPesquisa> createState() => _FiltrarPesquisaState();
}

class _FiltrarPesquisaState extends State<FiltrarPesquisa> {
  // Lista de categorias
  int selecionarFiltro = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children: List.generate(
              menuDoFiltro.length,
              (index) => InkWell(
                //* Ação para mudar de filtro
                onTap: () {
                  setState(() {
                    selecionarFiltro = index;
                  });
                },
                child: Container(
                  //* Alinhamento das palavras no retangulo dos filtros
                  alignment: Alignment.center,

                  margin: EdgeInsets.only(
                    left: 17.0,
                    right: index == menuDoFiltro.length - 1 ? 20.0 : 0,
                  ),

                  //* Comportamento quando um filtro é selecionado
                  decoration: BoxDecoration(
                    color: selecionarFiltro == index
                        ? Colors.blue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black12, width: 2.0),
                  ),

                  //* Comprimento e largura dos retangulos do filtro
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),

                    //* Comportamento do texto quando é selecionado um filtro
                    child: Text(
                      menuDoFiltro[index],
                      style: TextStyle(
                        color: selecionarFiltro == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
