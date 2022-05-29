import 'dart:convert';

import 'package:camarate_school_library/models/historico.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObrasRequisitadas extends StatelessWidget {
  const ObrasRequisitadas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
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
                    stream: FirebaseDatabase.instance.ref("historico").onValue,

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
                              final Historico hsitoricoBD =
                                  Historico.fromJson(valor);
                              // guardar apenas os valores que vou apresentar na lista
                              _obrasBD.add(hsitoricoBD);
                            });

                            //? INTERFACE PARA UTILIZADOR
                            // CONSTRUÇÃO DA TABELA COM OS DADOS DA BASE DE DADOS

                            return DataTable(
                              dataRowHeight: 65,
                              headingRowHeight: 45,
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey),

                              //? Colunas

                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'Título',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Data de requisição',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Data entrega',
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
                                    DataRow.byIndex(
                                      index: i,
                                      cells: <DataCell>[
                                        //* TÍtulo do livro
                                        DataCell(Text(
                                          _obrasBD[i].tituloLivro.toString(),
                                        )),

                                        //* Data de requisicao
                                        DataCell(Text(
                                          _obrasBD[i].dataRequisicao.toString(),
                                        )),

                                        //* Data de entrega
                                        DataCell(Text(
                                          _obrasBD[i].dataEntrega.toString(),
                                        )),
                                      ],
                                    ),
                                  ],
                              ],
                            );
                          } else {
                            return const Text("");
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
