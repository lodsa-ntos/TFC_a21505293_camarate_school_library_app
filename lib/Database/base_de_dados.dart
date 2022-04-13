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

    livros.addAll(listaDeLivros.livroModel);

    if (livros.isNotEmpty) {
      // ignore: avoid_print
      print('Livros carregados com sucesso da base de dados');
    } else {
      // ignore: avoid_print
      print('Sem dados para mostrar');
    }

    return livros;
  }
}
