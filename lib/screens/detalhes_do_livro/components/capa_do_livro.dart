import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../models/livro.dart';
import '../../../util/configurar_tamanho.dart';
import 'descricao_do_livro.dart';
import 'info_do_livro.dart';

// ignore: must_be_immutable
class CapaDoLivro extends StatelessWidget {
  CapaDoLivro({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: ConfigurarTamanho.orientation == Orientation.landscape
            ? size.width
            : size.height - AppBar().preferredSize.height,
        child: Stack(
          children: [
            InformacaoDoLivro(indexInformacao: index),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: DescricaoDoLivro(indexDescricao: index),
            ),
            StreamBuilder(
              stream: FirebaseDatabase.instance.ref("livros").onValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  //? Caso não esteja conectado, mostra mensagem
                  case ConnectionState.none:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text("Sem dados para mostrar...")
                      ],
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

                      return Positioned(
                        top: 40,
                        right: 15,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 179, 182, 188),
                                blurRadius: 5.0,
                                offset: Offset(0, 10),
                                spreadRadius: 0.5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              _livros[index].imagePath.toString(),
                              fit: BoxFit.cover,
                              height: 340, //378
                              width: 230,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      );
                    }
                }
                return const Text('');
              },
            ),
          ],
        ),
      ),
    );
  }
}
