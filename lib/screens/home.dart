import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:camarate_school_library/util/mostrar_seccoes_livros.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //

    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        return Scaffold(
          /// Menu Lateral

          //? CONSTRUIR INTERFACE PARA O UTILIZADOR

          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //* APRESENTAR LIVROS REQUISITADOS - INTERFACE PARA O UTILIZADOR

                ///Mostrar().livrosRequisitados,

                //? Título [Prateleiras] na interface
                prateleiras,

                espacamento,

                _categoria("Generalidades. Dicionários"),

                espacamento,

                //? CATEGORIA LIVROS GENERALIDADES
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: 333.0,
                    child: Mostrar().livrosSeccaoAmarela,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //? Separar as categorias
  _categoria(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                children: [
                  //_livroPrateleira,
                  if (titulo == "Generalidades. Dicionários") ...[
                    const CircleAvatar(
                      backgroundColor: Colors.yellow,
                      minRadius: 15,
                    ),
                  ] else if (titulo == "Filosofia e Psicologia") ...[
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 231, 205, 166),
                      minRadius: 15,
                    ),
                  ] else if (titulo == "Religião e Teologia") ...[
                    const CircleAvatar(
                      backgroundColor: Colors.orange,
                      minRadius: 15,
                    ),
                  ] else if (titulo == "Ciências Sociais") ...[
                    const CircleAvatar(
                      backgroundColor: Colors.brown,
                      minRadius: 15,
                    ),
                  ],

                  Padding(
                    // espaço entre o circulo e o título da classe
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*
          InkWell(
            onTap: () {},
            child: const Text(
              'ver todos',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          */
        ],
      ),
    );
  }
}

//** VARIÁVEIS GLOBAIS */

// espaçamento
const espacamento = SizedBox(
  height: 15,
);

// tÍtulo [Prateleiras]
const prateleiras = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Prateleiras',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
