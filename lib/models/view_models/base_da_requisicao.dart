import 'dart:async' show Future;
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../livro_requisitado.dart';

class BaseDeDadosRequisicao extends ChangeNotifier {
  List<LivroRequisitadoModelBD> livros = [];
  Map<String, dynamic> livrosRequisitados = <String, dynamic>{};

  //?___________________________Requisição da base de dados___________________________________

  Future<Map<String, dynamic>> getLivrosRequisitados(
      DatabaseReference referenciaLivroRequisitadoBD) async {
    //
    LivroRequisitadoModelBD listaDeObrasRequisitadas;

    // Obter os dados de só uma vez da referencia do firebase na base de dados
    DatabaseEvent livroRequisitadoBD =
        await referenciaLivroRequisitadoBD.once();

    Map<String, dynamic> respostaJSON =
        jsonDecode(jsonEncode(livroRequisitadoBD.snapshot.value));

    listaDeObrasRequisitadas = LivroRequisitadoModelBD.fromJson(respostaJSON);

    livrosRequisitados.addAll(listaDeObrasRequisitadas.requisitados);

    // Retorno a lista com os dados vindos da base de dados em JSON
    return livrosRequisitados;
  }
}
