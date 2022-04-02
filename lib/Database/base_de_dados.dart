import 'dart:convert';

import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async' show Future;

class BaseDeDados {
  List<LivroModel> livros = [];

  Future<List<LivroModel>> carregarLivrosBD(
      DatabaseReference referenciaLivrosBD) async {
    ListaDeLivros listaDeLivros;

    DatabaseEvent dadosSnapshot = await referenciaLivrosBD.once();

    List<dynamic> respostaJSON =
        jsonDecode(jsonEncode(dadosSnapshot.snapshot.value));

    listaDeLivros = ListaDeLivros.fromJSON(respostaJSON);
    // ignore: avoid_print
    print(listaDeLivros);

    livros.addAll(listaDeLivros.livroModel);

    // ignore: avoid_print
    print('Livro:  ${livros[0].titulo}');

    return livros;
  }
}
