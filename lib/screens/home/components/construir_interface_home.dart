import 'package:camarate_school_library/Screens/home/components/livros_prateleira.dart';
import 'package:camarate_school_library/Screens/home/components/livros_requisitados.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ConstruirInterfaceHome extends StatelessWidget {
  const ConstruirInterfaceHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          //* APRESENTAR LIVROS REQUISITADOS - INTERFACE PARA O UTILIZADOR

          MostrarLivrosRequisitados(),

          const Divider(height: 5),

          //? Título [Prateleiras] na interface
          biblioteca,

          espacamento,

          //?  LIVROS Prateleira
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 345.0,
              child: LivrosPrateleira(),
            ),
          ),
        ],
      ),
    );
  }
}

// espaçamento
const espacamento = SizedBox(
  height: 15,
);

// tÍtulo [Prateleiras]
final biblioteca = Padding(
  padding: const EdgeInsets.only(left: 20.0, top: 35.0),
  child: Row(
    children: const [
      Icon(
        FluentIcons.library_28_regular,
        color: Colors.black,
        size: 30,
      ),
      Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: Text(
          'Prateleira',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
);
