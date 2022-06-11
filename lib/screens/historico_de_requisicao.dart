import 'dart:convert';

import 'package:camarate_school_library/database/base_de_dados.dart';
import 'package:camarate_school_library/models/historico.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BaseDeDados baseDeDados = BaseDeDados();

DatabaseReference refDB = FirebaseDatabase.instance.ref();

class HistoricoDeRequisicao extends StatelessWidget {
  const HistoricoDeRequisicao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Histórico'),
          ),
          backgroundColor: Colors.white,

          //? HISTÓRICO DAS OBRAS REQUISITADAS

          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //? ALINHAMENTOS DA ESQUERDA PARA DIREITA
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //? Controlar a margem na esquerda e na direita
                  margin: const EdgeInsets.only(left: 3.0, right: 5.0),
                  child: StreamBuilder(
                    //? Referência
                    stream: refDB.child('historico').orderByChild('id').onValue,

                    // Chamar os dados da base de dados com [ AsyncSnapshot snapshot ]
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {

                        // Caso a conexão esteja em espera a aguardar interação, é apresentada na interface a mensagem ao utilizador
                        case ConnectionState.waiting:
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              CircularProgressIndicator(),
                              Text(" A carregar obras requisitados...")
                            ],
                          );

                        // Caso não exista conexão, é apresentada na interface a mensagem ao utilizador
                        case ConnectionState.none:
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text("Sem obras requisitados para mostrar...")
                            ],
                          );

                        default:

                          /// Se existir dados, e se não exister erros e os valores não são nulos
                          /// o histórico é construída com os dados providenciados da base de dados...
                          if (snapshot.hasData &&
                              !snapshot.hasError &&
                              snapshot.data.snapshot.value != null) {
                            //? Alcançar a instância da base de dados para autenticação do utilizador atual
                            final _auth = FirebaseAuth.instance;

                            // Utilizador atual
                            User? utilizador = _auth.currentUser;

                            /// Guardo os dados da base de dados [snapshot.data.snapshot.value]
                            /// numa coleção de pares chave/valor
                            Map<String, dynamic> dadosBaseDeDados = jsonDecode(
                                jsonEncode(snapshot.data.snapshot.value));

                            List<Historico> _obrasBD = [];

                            /// Com o forEach separo a chave e o valor para depois escolher o quero
                            /// guardar na lista [_obrasBD], nesse caso é o valor que depois...
                            dadosBaseDeDados.forEach((chave, valor) {
                              /// atribuo esses dados no fromJson da classe modelo do historico
                              Historico hsitoricoBD = Historico.fromJson(valor);
                              // guardar apenas os valores que vou apresentar na lista
                              _obrasBD.add(hsitoricoBD);
                            });

                            List<Historico> reverterLista =
                                _obrasBD.reversed.toList();

                            //? INTERFACE PARA UTILIZADOR
                            // CONSTRUÇÃO DA TABELA COM OS DADOS DA BASE DE DADOS

                            return SingleChildScrollView(
                              //? Scroll na horizontal para os dados nas colunas
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  DataTable(
                                    dataRowHeight: 65,
                                    headingRowHeight: 45,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.grey),

                                    //? Colunas

                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          'Data de requisição',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Título',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Data de entrega',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],

                                    //? Linhas

                                    rows: <DataRow>[
                                      for (int i = 0; i < _obrasBD.length; i++)
                                        if (_obrasBD[i].uidRequisitante ==
                                            utilizador!.uid) ...[
                                          DataRow(
                                            cells: [
                                              //* TÍtulo do livro
                                              DataCell(Text(
                                                _obrasBD[i]
                                                    .dataRequisicao
                                                    .toString(),
                                              )),

                                              //* Data de requisicão
                                              DataCell(Text(
                                                _obrasBD[i]
                                                    .tituloLivro
                                                    .toString(),
                                              )),

                                              //* Data de entrega
                                              DataCell(Text(
                                                _obrasBD[i]
                                                    .dataEntrega
                                                    .toString(),
                                              )),
                                            ],
                                          ),
                                        ],
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Text('');
                          }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
