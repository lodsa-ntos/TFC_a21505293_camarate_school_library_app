import 'dart:convert';
import 'dart:io';

import 'package:camarate_school_library/screens/detalhes_do_livro/livro_detalhado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/livro.dart';
import '../../../models/view_models/livro_requisitado_view_model.dart';

FirebaseDatabase refDB = FirebaseDatabase.instance;

class MostrarLivrosRequisitados extends StatelessWidget {
  const MostrarLivrosRequisitados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        //
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 25.0),
              child: Text(
                "Livros Requisitados",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //? StreamBuilder para carregar livros que foram requisitados
            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 20.0),
              height: 200.0,
              child: StreamBuilder(
                stream: refDB.ref('livros').onValue,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Platform.isAndroid
                              ? const CircularProgressIndicator()
                              : const CupertinoActivityIndicator(),
                          const Text(" A carregar livros requisitados...")
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
                        List<dynamic> dadosBaseDeDados = jsonDecode(
                            jsonEncode(snapshot.data.snapshot.value));

                        List<Livro> _livrosBD = dadosBaseDeDados
                            .map((livroBD) => Livro.fromJson(livroBD))
                            .toList();

                        return snapshot.hasData
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: List.generate(
                                          _livrosBD.length,
                                          (int index) {
                                            if (_livrosBD[index].uidLivro ==
                                                    utilizador!.uid &&
                                                _livrosBD[index]
                                                        .isRequisitado ==
                                                    true) {
                                              return ConstruirAspetoLivrosRequisitados(
                                                indexAspeto: index,
                                                pressionar: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      //? Redireciona o utilizador para a página de detalhes do livro */
                                                      builder: (context) =>
                                                          LivroDetalhado(
                                                        index: index,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }

                                            //! LISTA SEMPRE CHEIA NÃO PARA MOSTRAR MENSAGEM - ENCONTRAR SOLUÇÃO
                                            return const Text('');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text('Sem livros requisitados...'),
                              );
                      }
                  }
                  return const Text('sem dados');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class ConstruirAspetoLivrosRequisitados extends StatelessWidget {
  final int indexAspeto;
  final Function() pressionar;

  const ConstruirAspetoLivrosRequisitados(
      {Key? key, required this.indexAspeto, required this.pressionar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressionar,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        width: 120, //145
        decoration: BoxDecoration(
          color: const Color.fromRGBO(243, 246, 248, 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: StreamBuilder(
          stream: FirebaseDatabase.instance.ref("livros").onValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              //? Caso não esteja conectado, mostra mensagem
              case ConnectionState.none:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[Text("Sem dados para mostrar...")],
                );

              default:
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  List<dynamic> dadosBaseDeDados =
                      jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                  LivroModel listaDeLivros =
                      LivroModel.fromJson(dadosBaseDeDados);

                  final List<Livro> _livros = [];

                  _livros.addAll(listaDeLivros.livros);

                  return AspectRatio(
                    aspectRatio: 0.615,
                    child: Column(
                      children: <Widget>[
                        //
                        //* Imagem do livro
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/gifs/carregar.gif',
                              image: _livros[indexAspeto].imagePath.toString(),
                              fit: BoxFit.fitWidth,
                              height: 120,
                              width: 110,
                            ),
                          ),
                        ),

                        //* Título
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              _livros[indexAspeto].titulo.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),

                        //
                        const SizedBox(height: 2),

                        //? Data de entrega
                        Text(
                          'Data de entrega: \n' +
                              _livros[indexAspeto].dataEntrega.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Syabil',
                          ),
                        ),
                      ],
                    ),
                  );
                }
            }
            return const Text('sem dados');
          },
        ),
      ),
    );
  }
}
