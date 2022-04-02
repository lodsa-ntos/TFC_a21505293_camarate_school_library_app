import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async' show Future;

class BaseDeDados {
  List<LivroModel> livros = [];

  Future<List<LivroModel>> carregarLivrosBD(
      DatabaseReference referenciaLivrosBD) async {
    ListaDeLivros listaDeLivros;

    DatabaseEvent dadosSnapshot = await referenciaLivrosBD.once();

    Map<String, dynamic> respostaJSON =
        dadosSnapshot.snapshot.value as Map<String, dynamic>;

    listaDeLivros = ListaDeLivros.fromJSON(respostaJSON);
    print(listaDeLivros);

    livros.addAll(listaDeLivros.listaDeLivros);

    print('Livro:  ${livros[0].titulo}');

    return livros;
  }
}
