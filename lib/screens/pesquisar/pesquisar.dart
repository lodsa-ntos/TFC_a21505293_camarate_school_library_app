import 'dart:convert';
import 'dart:io';

import 'package:camarate_school_library/Models/view_models/conetividade.dart';
import 'package:camarate_school_library/Screens/sem_internet.dart';
import 'package:camarate_school_library/models/livro.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../detalhes_do_livro/livro_detalhado.dart';
import 'components/caixa_de_pesquisa.dart';
import 'components/construir_filtros_pesquisa.dart';

String _condicao = '';

class PesquisaDeLivro extends StatefulWidget {
  const PesquisaDeLivro({Key? key}) : super(key: key);

  @override
  _PesquisaDeLivroState createState() {
    return _PesquisaDeLivroState();
  }
}

class _PesquisaDeLivroState extends State<PesquisaDeLivro> {
  TextEditingController _controladorDoTexto = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controladorDoTexto = TextEditingController()..addListener(_textoAlterado);
    Provider.of<Conectividade>(context, listen: false).verificarLigacao();
  }

  /// libertar espaços da memória
  @override
  void dispose() {
    _controladorDoTexto.dispose();
    super.dispose();
  }

  /// controlar a mudança de texto caixa de pesquisa
  void _textoAlterado() {
    setState(() {
      _condicao = _controladorDoTexto.text;
    });
  }

  Widget _barraDePesquisa() {
    _condicao = _controladorDoTexto.text;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CaixaDePesquisa(
        controlador: _controladorDoTexto,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pesquisarLivrosBD = Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        return StreamBuilder(
          stream: FirebaseDatabase.instance.ref("livros").onValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Platform.isAndroid
                        ? const CircularProgressIndicator()
                        : const CupertinoActivityIndicator(),
                    const Text(" A carregar livros...")
                  ],
                );

              case ConnectionState.none:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[Text("Sem livros para mostrar...")],
                );

              default:
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  List<dynamic> dadosBaseDeDados =
                      jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                  LivroModel listaDeLivros =
                      LivroModel.fromJson(dadosBaseDeDados);

                  List<Livro> _livros = [];

                  _livros.addAll(listaDeLivros.livros);

                  /// snapshot.data --> livros da bases de dados
                  final livroBD = _filtrarPesquisa(_livros);

                  return Flexible(
                    child: livroBD.isNotEmpty
                        ? ListView.builder(
                            /// comportamento para que o ListView
                            /// ocupe apenas o espaço necessário dos dados
                            /// a serem mostrados na interface
                            shrinkWrap: true,

                            // até ao último livro da lista
                            itemCount: livroBD.length,

                            // mostra todos os livros da lista contidos na base de dados
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    /// redireciona o utilizador para a página de detalhes do livro
                                    builder: (context) => LivroDetalhado(
                                      index: _livros.indexOf(livroBD[index]),
                                    ),
                                  ),
                                ),
                                child: SafeArea(
                                  top: false,
                                  bottom: false,
                                  minimum: const EdgeInsets.only(
                                    left: 16,
                                    top: 8,
                                    bottom: 8,
                                    right: 8,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 5.0,
                                        right: 12.0,
                                        top: 8.0,
                                        bottom: 8.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Stack(
                                            children: [
                                              Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                elevation: 4,
                                                child: SizedBox(
                                                  height: 150.0,
                                                  width: 100.0,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          'assets/gifs/carregar.gif',
                                                      image: livroBD[index]
                                                          .imagePath
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      height: 150.0,
                                                      width: 100.0,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //* Icone estado requisitado
                                              if (livroBD[index]
                                                      .isRequisitado ==
                                                  true) ...[
                                                Positioned(
                                                  top: 10,
                                                  right: 10,
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xff34A853),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: const Icon(
                                                      FluentIcons
                                                          .accessibility_checkmark_24_regular,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //* título do livro
                                                Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  child: Text(
                                                    livroBD[index]
                                                        .titulo
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6!
                                                          .color,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                const SizedBox(height: 5.0),

                                                //* Autor
                                                Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  child: Text(
                                                    livroBD[index]
                                                        .autor
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      color: Color(0xff4285f4),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 10.0),

                                                Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  child: Text(
                                                    livroBD[index]
                                                        .descricao
                                                        .toString(),
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.0,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .color,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                            "Livro não encontrado...",
                            style: TextStyle(color: Colors.black),
                          )),
                  );
                }
                return const Text("Sem dados");
            }
          },
        );
      },
    );
    return Consumer<Conectividade>(builder: (context, utilizador, child) {
      if (utilizador.isOnline != null) {
        return utilizador.isOnline ?? false
            ? Consumer<LivroRequisitadoModel>(
                builder: (BuildContext context,
                    LivroRequisitadoModel requisitadoModel, Widget? child) {
                  return Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        icon: SvgPicture.asset("assets/icons/voltar.svg"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(
                        'Pesquisar',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline6!.color,
                        ),
                      ),
                      backgroundColor: const Color(0xffF6F6F6),
                      elevation: 0,
                    ),
                    body: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color(0xffF6F6F6),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),

                            //* Barra de pesquisa
                            _barraDePesquisa(),

                            const SizedBox(height: 15),

                            //* Filtros para pesquisar
                            const FiltrosDePesquisa(),

                            const SizedBox(height: 20),

                            //* Livros
                            pesquisarLivrosBD,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : SemInternet();
      }
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

//* Regra para filtrar a pesquisa
List<Livro> _filtrarPesquisa(caixaDePesquisa) {
  if (_condicao.isNotEmpty == true) {
    //* Título
    if (selecionarFiltro == 0) {
      return caixaDePesquisa
              ?.where((element) =>
                  element.titulo
                      .toString()
                      .toLowerCase()
                      .contains(_condicao.toLowerCase()) ||
                  element.numRegisto
                      .toString()
                      .toLowerCase()
                      .contains(_condicao.toLowerCase()))
              .toList() ??
          <Livro>[];

      //* Autor
    } else if (selecionarFiltro == 1) {
      return caixaDePesquisa
              ?.where(
                (element) => element.autor
                    .toString()
                    .toLowerCase()
                    .contains(_condicao.toLowerCase()),
              )
              .toList() ??
          <Livro>[];

      //* Título
    } else if (selecionarFiltro == 2) {
      return caixaDePesquisa
              ?.where(
                (element) => element.texto
                    .toString()
                    .toLowerCase()
                    .contains(_condicao.toLowerCase()),
              )
              .toList() ??
          <Livro>[];

      //* Ano de publicação
    } else if (selecionarFiltro == 3) {
      return caixaDePesquisa
              ?.where(
                (element) => element.ano
                    .toString()
                    .toLowerCase()
                    .contains(_condicao.toLowerCase()),
              )
              .toList() ??
          <Livro>[];
    }
  }

  return caixaDePesquisa ?? <Livro>[];
}
