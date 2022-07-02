import 'dart:convert';
import 'dart:io';

import 'package:camarate_school_library/database/base_de_dados.dart';
import 'package:camarate_school_library/models/historico.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

BaseDeDados baseDeDados = BaseDeDados();

DatabaseReference refDB = FirebaseDatabase.instance.ref('historico');

class HistoricoDeRequisicao extends StatelessWidget {
  const HistoricoDeRequisicao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: SvgPicture.asset("assets/icons/voltar.svg"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Histórico',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headline6!.color,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                    stream: refDB.onValue,

                    // Chamar os dados da base de dados com [ AsyncSnapshot snapshot ]
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {

                        // Caso a conexão esteja em espera a aguardar interação, é apresentada na interface a mensagem ao utilizador
                        case ConnectionState.waiting:
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Altera o loading, para os dispositivos android e ios
                              Platform.isAndroid
                                  ? const CircularProgressIndicator()
                                  : const CupertinoActivityIndicator(),
                              const Text(" A carregar obras requisitados...")
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
                            dadosBaseDeDados.forEach(
                              (chave, valor) {
                                /// atribuo esses dados no fromJson da classe modelo do historico
                                Historico hsitoricoBD =
                                    Historico.fromJson(valor);
                                // guardar apenas os valores que vou apresentar na lista
                                _obrasBD.add(hsitoricoBD);
                              },
                            );

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
                                            (states) => Color(0xff4285f4)),

                                    //? Colunas

                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          'Data de requisição',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Título',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Data de entrega',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                              DataCell(
                                                Text(
                                                  _obrasBD[i]
                                                      .dataRequisicao
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),

                                              //* Data de requisicão
                                              DataCell(
                                                Text(
                                                  _obrasBD[i]
                                                      .tituloLivro
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),

                                              //* Data de entrega
                                              DataCell(
                                                Text(
                                                  _obrasBD[i]
                                                      .dataEntrega
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
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
