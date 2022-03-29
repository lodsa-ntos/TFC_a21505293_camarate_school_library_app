import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:flutter/material.dart';

//* Variavel para controlar as escolhas dos filtros
int selecionarFiltro = 0;

class ConstruirFiltrosDePesquisa extends StatefulWidget {
  const ConstruirFiltrosDePesquisa({Key? key}) : super(key: key);

  @override
  State<ConstruirFiltrosDePesquisa> createState() =>
      _ConstruirFiltrosDePesquisaState();
}

//* Classe para montar os menus do filtro de pesquisa
class _ConstruirFiltrosDePesquisaState
    extends State<ConstruirFiltrosDePesquisa> {
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
