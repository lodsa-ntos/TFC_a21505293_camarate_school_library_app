import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/livro.dart';
import '../models/view_models/livro_requisitado_view_model.dart';
import '../screens/livro_detalhado.dart';

import 'package:intl/intl.dart';

class Mostrar {
  //? StreamBuilder para carregar livros que foram requisitados
  final livrosRequisitados = Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Livros Requisitados',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 3.0, right: 5.0),
          child: StreamBuilder(
            stream: FirebaseDatabase.instance.ref("livros").onValue,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      Text(" A carregar livros requisitados...")
                    ],
                  );

                case ConnectionState.none:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text("Sem livros para mostrar...")
                    ],
                  );

                default:
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    // Alcançar a instância da base de dados para autenticação do utilizador atual
                    final _auth = FirebaseAuth.instance;

                    // Utilizador actual
                    User? utilizador = _auth.currentUser;

                    var data = DateTime.now().toLocal();
                    var formato = DateFormat('dd-MM-yyyy');

                    String dataAtual = formato.format(data.toLocal());
                    String dataUmDiaAntes =
                        formato.format(data.subtract(const Duration(days: 1)));
                    String dataSemEntregar =
                        formato.format(data.add(const Duration(days: 1)));

                    //? tRanformar os dados da base de dados numa lista dinamica
                    List<dynamic> dadosBaseDeDados =
                        jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                    //? Adaptar ao modelo de livro
                    LivroModel listaDeLivros =
                        LivroModel.fromJson(dadosBaseDeDados);

                    //? Lista para guardar os dados convertidos e decodificados
                    final List<Livro> _livros = [];

                    _livros.addAll(listaDeLivros.livros);

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      height: 290.0,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _livros.length,
                              itemBuilder: (context, index) {
                                //* Construir livro requisitado na interface
                                if (_livros[index].uidLivro ==
                                        utilizador!.uid &&
                                    _livros[index].isRequisitado == true) {
                                  return InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //? Redireciona o utilizador para a página de detalhes do livro */
                                        builder: (context) => LivroDetalhado(
                                          index: index,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 103.0,
                                          margin:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 120.66,
                                                height: 155.5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      _livros[index]
                                                          .imagePath
                                                          .toString(),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Text(
                                                _livros[index]
                                                    .titulo
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              if (_livros[index].dataEntrega ==
                                                      dataAtual ||
                                                  _livros[index].dataEntrega ==
                                                      dataUmDiaAntes ||
                                                  _livros[index].dataEntrega ==
                                                      dataSemEntregar) ...[
                                                Text(
                                                  'Data de devolução: ' +
                                                      _livros[index]
                                                          .dataEntrega
                                                          .toString(),
                                                  style: GoogleFonts.catamaran(
                                                    textStyle: const TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ] else ...[
                                                Text(
                                                  'Data de entrega: ' +
                                                      _livros[index]
                                                          .dataEntrega
                                                          .toString(),
                                                  style: GoogleFonts.catamaran(
                                                    textStyle: const TextStyle(
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                ),
                                              ]
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text("Sem dados");
                  }
              }
            },
          ),
        ),
      ],
    );
  });

  //? StreamBuilder para carregar da base de dados os livros com o número de coleção ZERO
  final livrosSeccaoAmarela = Consumer<LivroRequisitadoModel>(
    builder: (context, requisitadoModel, child) {
      return StreamBuilder(
        stream: FirebaseDatabase.instance.ref("livros").onValue, // async work
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text(" A carregar livros...")
                ],
              );

            case ConnectionState.none:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[Text("Sem livros para mostrar...")],
              );

            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  List<dynamic> dadosBaseDeDados =
                      jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                  LivroModel listaDeLivros =
                      LivroModel.fromJson(dadosBaseDeDados);

                  List<Livro> _livrosPrateleira = [];

                  _livrosPrateleira.addAll(listaDeLivros.livros);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _livrosPrateleira.length,
                    itemBuilder: (BuildContext context, int index) {
                      //
                      //? variável para representar o estado de requisição
                      String _estadoDeRequisicao =
                          _livrosPrateleira[index].isRequisitado.toString();

                      switch (_livrosPrateleira[index].numColecao) {
                        case "0":
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //** Redireciona o utilizador para a página de detalhes do livro */
                                  builder: (context) => LivroDetalhado(
                                    index: index,
                                  ),
                                ),
                              );
                            },

                            //** Widgets que vão desenvolver formato dos livros a serem apresentados
                            //** no página home */
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 122.0,
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 121.66,
                                          height: 190.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              //** Capa */
                                              image: NetworkImage(
                                                _livrosPrateleira[index]
                                                    .imagePath
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12.0),

                                        //** Titulo */
                                        Text(
                                            _livrosPrateleira[index]
                                                .titulo
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            )),

                                        const SizedBox(height: 5.0),

                                        //** Autor */
                                        Text(_livrosPrateleira[index]
                                            .autor
                                            .toString()),

                                        const SizedBox(height: 5.0),

                                        //** isRequisitado */

                                        if (_livrosPrateleira[index]
                                                .isRequisitado ==
                                            true) ...[
                                          const Text(
                                            'Requisitado',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        default:
                          return const Text('');
                      }

                      //
                    },
                  );
                }
              }
              return const Text("Sem dados...");
          }
        },
      );
    },
  );

  //? StreamBuilder para carregar da base de dados os livros com o número de coleção UM
  final livrosSeccaoBeje = Consumer<LivroRequisitadoModel>(
    builder: (context, requisitadoModel, child) {
      return StreamBuilder(
        stream: FirebaseDatabase.instance.ref("livros").onValue, // async work
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text(" A carregar livros...")
                ],
              );

            case ConnectionState.none:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[Text("Sem livros para mostrar...")],
              );

            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  List<dynamic> dadosBaseDeDados =
                      jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                  LivroModel listaDeLivros =
                      LivroModel.fromJson(dadosBaseDeDados);

                  List<Livro> _livrosPrateleira = [];

                  _livrosPrateleira.addAll(listaDeLivros.livros);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _livrosPrateleira.length,
                    itemBuilder: (BuildContext context, int index) {
                      //
                      //? variável para representar o estado de requisição
                      String _estadoDeRequisicao =
                          _livrosPrateleira[index].isRequisitado.toString();

                      switch (_livrosPrateleira[index].numColecao) {
                        case "1":
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //** Redireciona o utilizador para a página de detalhes do livro */
                                  builder: (context) => LivroDetalhado(
                                    index: index,
                                  ),
                                ),
                              );
                            },

                            //** Widgets que vão desenvolver formato dos livros a serem apresentados
                            //** no página home */
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 122.0,
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 121.66,
                                          height: 190.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              //** Capa */
                                              image: NetworkImage(
                                                _livrosPrateleira[index]
                                                    .imagePath
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12.0),

                                        //** Titulo */
                                        Text(
                                            _livrosPrateleira[index]
                                                .titulo
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            )),

                                        const SizedBox(height: 5.0),

                                        //** Autor */
                                        Text(_livrosPrateleira[index]
                                            .autor
                                            .toString()),

                                        const SizedBox(height: 5.0),

                                        //** isRequisitado */
                                        Text(
                                          _estadoDeRequisicao.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        default:
                          return const Text('');
                      }

                      //
                    },
                  );
                }
              }
              return const Text("Sem dados...");
          }
        },
      );
    },
  );

  //? StreamBuilder para carregar da base de dados os livros com o número de coleção DOIS
  final livrosSeccaoLaranja = Consumer<LivroRequisitadoModel>(
    builder: (context, requisitadoModel, child) {
      return StreamBuilder(
        stream: FirebaseDatabase.instance.ref("livros").onValue, // async work
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text(" A carregar livros...")
                ],
              );

            case ConnectionState.none:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[Text("Sem livros para mostrar...")],
              );

            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  List<dynamic> dadosBaseDeDados =
                      jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                  LivroModel listaDeLivros =
                      LivroModel.fromJson(dadosBaseDeDados);

                  List<Livro> _livrosPrateleira = [];

                  _livrosPrateleira.addAll(listaDeLivros.livros);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _livrosPrateleira.length,
                    itemBuilder: (BuildContext context, int index) {
                      //
                      //? variável para representar o estado de requisição
                      String _estadoDeRequisicao =
                          _livrosPrateleira[index].isRequisitado.toString();

                      switch (_livrosPrateleira[index].numColecao) {
                        case "2":
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //** Redireciona o utilizador para a página de detalhes do livro */
                                  builder: (context) => LivroDetalhado(
                                    index: index,
                                  ),
                                ),
                              );
                            },

                            //** Widgets que vão desenvolver formato dos livros a serem apresentados
                            //** no página home */
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 122.0,
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 121.66,
                                          height: 190.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              //** Capa */
                                              image: NetworkImage(
                                                _livrosPrateleira[index]
                                                    .imagePath
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12.0),

                                        //** Titulo */
                                        Text(
                                            _livrosPrateleira[index]
                                                .titulo
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            )),

                                        const SizedBox(height: 5.0),

                                        //** Autor */
                                        Text(_livrosPrateleira[index]
                                            .autor
                                            .toString()),

                                        const SizedBox(height: 5.0),

                                        //** isRequisitado */
                                        Text(
                                          _estadoDeRequisicao.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        default:
                          return const Text('');
                      }

                      //
                    },
                  );
                }
              }
              return const Text("Sem dados...");
          }
        },
      );
    },
  );

  //? StreamBuilder para carregar da base de dados os livros com o número de coleção TRÊS
  final livrosSeccaoCastanho = Consumer<LivroRequisitadoModel>(
    builder: (context, requisitadoModel, child) {
      return StreamBuilder(
        stream: FirebaseDatabase.instance.ref("livros").onValue, // async work
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text(" A carregar livros...")
                ],
              );

            case ConnectionState.none:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[Text("Sem livros para mostrar...")],
              );

            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  List<dynamic> dadosBaseDeDados =
                      jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                  LivroModel listaDeLivros =
                      LivroModel.fromJson(dadosBaseDeDados);

                  List<Livro> _livrosPrateleira = [];

                  _livrosPrateleira.addAll(listaDeLivros.livros);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _livrosPrateleira.length,
                    itemBuilder: (BuildContext context, int index) {
                      //
                      //? variável para representar o estado de requisição
                      String _estadoDeRequisicao =
                          _livrosPrateleira[index].isRequisitado.toString();

                      switch (_livrosPrateleira[index].numColecao) {
                        case "3":
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //** Redireciona o utilizador para a página de detalhes do livro */
                                  builder: (context) => LivroDetalhado(
                                    index: index,
                                  ),
                                ),
                              );
                            },

                            //** Widgets que vão desenvolver formato dos livros a serem apresentados
                            //** no página home */
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 122.0,
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 121.66,
                                          height: 190.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              //** Capa */
                                              image: NetworkImage(
                                                _livrosPrateleira[index]
                                                    .imagePath
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12.0),

                                        //** Titulo */
                                        Text(
                                            _livrosPrateleira[index]
                                                .titulo
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            )),

                                        const SizedBox(height: 5.0),

                                        //** Autor */
                                        Text(_livrosPrateleira[index]
                                            .autor
                                            .toString()),

                                        const SizedBox(height: 5.0),

                                        //** isRequisitado */
                                        Text(
                                          _estadoDeRequisicao.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        default:
                          return const Text('');
                      }

                      //
                    },
                  );
                }
              }
              return const Text("Sem dados...");
          }
        },
      );
    },
  );
}
