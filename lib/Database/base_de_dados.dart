import 'dart:convert';

import 'package:camarate_school_library/models/livro_model.dart';
import 'package:camarate_school_library/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async' show Future;

import 'package:flutter/material.dart';

class BaseDeDados {
  BuildContext? context;
  List<LivroModel> livros = [];

  Future<List<LivroModel>> carregarLivrosBD(
      DatabaseReference referenciaLivrosBD) async {
    //
    RepositorioDeLivros listaDeLivros;

    /// Obter os dados de só uma vez da referencia do firebase na base de dados
    DatabaseEvent dadosSnapshot = await referenciaLivrosBD.once();

    // Com jsonEncode Converter todos os valor da base de dados numa string JSON
    //[{"id":1,"nome":"Livro #1"},{"id":2,"nome":"Livro #2"}]

    /// Com o jsonDecode, os valores vao ser codificados e transformados e
    /// guardados no formato de uma List<dynamic>
    List<dynamic> respostaJSON =
        jsonDecode(jsonEncode(dadosSnapshot.snapshot.value));

    /// Depois de receber os dados que quero guardar do RepositorioDeLivros
    /// de acoddo ao Modelo de livro, coloco esses dados na List<LivroModel> livros = [];
    /// que é uma lista dynamica mas do tipo LivroModel
    listaDeLivros = RepositorioDeLivros.fromJSON(respostaJSON);

    /// Coloco esses dados na lista
    livros.addAll(listaDeLivros.livroModel);

    if (!livros.isNotEmpty) {
      // ignore: avoid_print
      print('Sem livros para mostrar');
    }

    /// Retorno a lista com os dados vindos da base de dados em JSON
    return livros;
  }

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context!).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }
}
