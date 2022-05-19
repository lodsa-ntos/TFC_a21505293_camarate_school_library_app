import 'package:flutter/material.dart';

class ObrasRequisitadas extends StatelessWidget {
  const ObrasRequisitadas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //? seta para voltar a página anterior
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0, //? retirar a sombra da barra do título
        backgroundColor: Colors.white, //? Cor da barra do título
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(
              30.0), //? distância entre o título e a seta para voltar

          //? Título
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: const [
                Text(
                  'Obras requisitadas',
                  style: TextStyle(color: Colors.black, fontSize: 30.0),
                ),
              ],
            ),
          ),
          //? _______________________________________________________________
        ),
      ),
      backgroundColor: Colors.white,

      //? DADOS DAS OBRAS REQUISITADAS

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Livro',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Requisitante',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Data de requisição',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Alquimista (16x)')),
                            DataCell(Text('Joaquín Santos')),
                            DataCell(Text('16/05/2022 - 15:34')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Que número é este (5x)')),
                            DataCell(Text('João Silva')),
                            DataCell(Text('19/05/2022 - 13:44')),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
