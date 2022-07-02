import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/livro.dart';
import '../../../models/view_models/livro_requisitado_view_model.dart';
import '../../detalhes_do_livro/livro_detalhado.dart';

class LivrosPrateleira extends StatelessWidget {
  const LivrosPrateleira({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        return StreamBuilder(
          //
          stream: FirebaseDatabase.instance.ref("livros").onValue,

          //
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

                    List<dynamic> _livros = [];

                    _livros.addAll(listaDeLivros.livros);

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _livros.length,
                      itemBuilder: (BuildContext context, int index) {
                        //
                        Size _distanciarLivros = MediaQuery.of(context).size;

                        return Container(
                          //Distancia livros
                          margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                          width: _distanciarLivros.width * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
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
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 125.66,
                                      height: 170.5,
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(15),
                                        ),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/gifs/carregar.gif',
                                          image: _livros[index]
                                              .imagePath
                                              .toString(),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),

                                    //* Icone estado requisitado
                                    if (_livros[index].isRequisitado ==
                                        true) ...[
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff34A853),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
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
                              ),
                              InkWell(
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
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(243, 246, 248, 1),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 10),
                                        blurRadius: 50,
                                        color:
                                            const Color.fromRGBO(27, 68, 166, 1)
                                                .withOpacity(0.23),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _livros[index].titulo.toString(),
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                fontFamily: 'Syabil',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),

                                            const SizedBox(height: 5.0),

                                            //** Autor */
                                            Text(
                                              _livros[index].autor.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: 'Syabil',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
                return const Text("");
            }
          },
        );
      },
    );
  }
}
