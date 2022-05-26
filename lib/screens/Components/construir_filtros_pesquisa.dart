import 'package:camarate_school_library/models/livro.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Variavel para controlar as escolhas dos filtros
int selecionarFiltro = 0;

class FiltrosDePesquisa extends StatefulWidget {
  const FiltrosDePesquisa({Key? key}) : super(key: key);

  @override
  State<FiltrosDePesquisa> createState() => _FiltrosDePesquisaState();
}

//* Classe para montar os menus do filtro de pesquisa
class _FiltrosDePesquisaState extends State<FiltrosDePesquisa> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (BuildContext context, LivroRequisitadoModel detalheModel,
          Widget? child) {
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
      },
    );
  }
}
