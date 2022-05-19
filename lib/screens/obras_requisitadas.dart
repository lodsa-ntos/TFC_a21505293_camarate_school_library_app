import 'package:flutter/material.dart';

class ObrasRequisitadas extends StatelessWidget {
  const ObrasRequisitadas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Obras requisitadas',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 34),
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
                            DataCell(Text('16/05/2022')),
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
