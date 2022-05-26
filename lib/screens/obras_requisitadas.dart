import 'package:camarate_school_library/models/livro_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ObrasRequisitadas extends StatelessWidget {
  const ObrasRequisitadas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        FirebaseFirestore.instance.collection('historico').get();

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

      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('historico')
              .doc()
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasData == false) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text(" A carregar obras requisitadas...")
                ],
              );
            }

            if (snapshot.data == null) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[Text("Sem obras requisitadas...")],
              );
            }

            if (snapshot.hasData) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Título')),
                      DataColumn(label: Text('Requisitante')),
                      DataColumn(
                        label: Text('Data de requisição',
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                    rows: [],
                  ));
            }

            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Text('No Players');
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Text('No Data');
          }),
    );
  }
}
