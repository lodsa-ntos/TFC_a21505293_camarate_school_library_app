import 'dart:convert';

import 'package:camarate_school_library/models/historico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../database/base_de_dados.dart';

//? Alcançar a instância da base de dados para autenticação do utilizador atual
final _auth = FirebaseAuth.instance;
User? utilizador = _auth.currentUser;
Historico hist = Historico();

class ObrasRequisitadas extends StatelessWidget {
  const ObrasRequisitadas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    hist.idLivro = utilizador!.uid;
    BaseDeDados baseDeDados = BaseDeDados();
    final databaseRef = FirebaseDatabase.instance
        .ref('historico')
        .child(hist.idLivro.toString());
    String idAleatorio = databaseRef.push().key!;

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

      //? HISTÓRICO DAS OBRAS REQUISITADAS

      body: StreamBuilder(
          stream: databaseRef.onValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            // Se a conectação estiver em espera a aguardar interação, apresenta mensagem ao utilizador
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

            // Se os dados forem nulos e terem dados, apresenta mensagem ao utilizador
            if (snapshot.data == null) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[Text("Sem obras requisitadas...")],
              );
            }

            // Se existir dados, o hsitorico é construído...
            if (snapshot.hasData && snapshot.data.snapshot.value != null) {
              //? Obter os dados guardados pelo utilizador
              Map<String, dynamic> dadosBaseDeDados =
                  jsonDecode(jsonEncode(snapshot.data.snapshot.value));

              HistoricoModel obrasR = HistoricoModel.fromJson(dadosBaseDeDados);

              Map<String, dynamic> _obras = <String, dynamic>{};

              _obras.addAll(obrasR.obrasRequisitadas);

              return SingleChildScrollView(
                  //? Scroll na vertical para os dados nas linhas
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    //? Scroll na horizontal para os dados nas colunas
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,

                    // Construir tabela
                    child: DataTable(
                      //? Colunas
                      columns: const [
                        DataColumn(
                            label: Text(
                          'ID',
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(label: Text('Título')),
                        DataColumn(label: Text('Requisitante')),
                        DataColumn(
                          label: Text('Data de requisição',
                              overflow: TextOverflow.ellipsis),
                        ),
                        DataColumn(
                          label: Text('Data de entrega',
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],

                      //? Linhas
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                                Historico.fromJson(_obras).idLivro.toString())),
                            DataCell(Text(Historico.fromJson(_obras)
                                .tituloLivro
                                .toString())),
                            DataCell(Text(Historico.fromJson(_obras)
                                .requisitante
                                .toString())),
                            DataCell(Text(Historico.fromJson(_obras)
                                .dataRequisicao
                                .toString())),
                            DataCell(Text(Historico.fromJson(_obras)
                                .dataEntrega
                                .toString())),
                          ],
                        ),
                      ],
                    ),
                  ));
            }

            // Se não tem dados e conexão terminou, apresenta mensagem vazia interface
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Text('');
            }

            // Se a conexão terminou, apresenta mensagem vazia na interface
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text("  A carregar obras requisitadas...")
                  ],
                ),
              );
            }

            return const Text('Sem obras');
          }),
    );
  }
}
