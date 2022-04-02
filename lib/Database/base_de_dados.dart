import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async' show Future;

class BaseDeDados {
  List<LivroModel> livros = [];

  Future<List<LivroModel>> carregarLivrosBD(
      DatabaseReference referenciaLivrosBD) async {
    ListaDeLivros recipeList;

    DataSnapshot dataSnapshot = await referenciaLivrosBD.once();

    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value[0]['content'];

    return livros;
  }
}
