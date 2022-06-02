import 'dart:convert';

import 'package:camarate_school_library/models/categoria.dart';
import 'package:camarate_school_library/models/livro.dart';
import 'package:camarate_school_library/models/pessoa.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async' show Future;

import '../models/historico.dart';

class BaseDeDados {
  List<Livro> livros = [];
  List<Categoria> categorias = [];
  Map<String, dynamic> pessoas = <String, dynamic>{};
  Map<String, dynamic> obras = <String, dynamic>{};

  //?_________________________________________Livros da base de dados_________________________________________________________

  Future<List<Livro>> getLivrosBD(DatabaseReference referenciaLivrosBD) async {
    //
    LivroModel listaDeLivros;

    // Obter os dados de só uma vez da referencia do firebase na base de dados
    DatabaseEvent dadosBD = await referenciaLivrosBD.once();

    // Com jsonEncode Converter todos os valor da base de dados numa string JSON
    // [{"id":1,"nome":"Livro>  #1"},{"id":2,"nome":"Livro>  #2"}]

    // Com o jsonDecode, os valores vao ser codificados e transformados e
    // guardados no formato de uma List<dynamic>
    List<dynamic> respostaJSON = jsonDecode(jsonEncode(dadosBD.snapshot.value));

    // Depois de receber os dados que quero guardar do RepositorioDeLivros
    // de acordo ao Modelo de livro, coloco esses dados na List<LivroModel> livros = [];
    // que é uma lista dinamica mas do tipo LivroModel
    listaDeLivros = LivroModel.fromJson(respostaJSON);

    // Guardar os dados da BD na lista
    livros.addAll(listaDeLivros.livros);

    // Retorno a lista com os dados vindos da base de dados em JSON
    return livros;
  }

  //?_________________________________________Utilizadores da base de dados_________________________________________________________

  Future<Map<String, dynamic>> getUtilizadoresBD(
      DatabaseReference referenciaUtilizadoresBD) async {
    //
    PessoaModel listaDeUtilizadores;

    // Obter os dados de só uma vez da referencia do firebase na base de dados
    DatabaseEvent dadosUtilizadorBD = await referenciaUtilizadoresBD.once();

    // Com o jsonDecode, os valores vao ser codificados, transformados e
    // guardados no formato de um Map<String, dynamic>
    Map<String, dynamic> respostaJSON =
        jsonDecode(jsonEncode(dadosUtilizadorBD.snapshot.value));

    // Depois de receber os dados que quero guardar do RepositorioDeUtilizadores
    // de acordo ao Modelo de pessoa, coloco esses dados num Map<String, dynamic>;
    // que é uma coleção de pares chave/valor mas do tipo PessoaModel
    listaDeUtilizadores = PessoaModel.fromJson(respostaJSON);

    // Guardar os dados da BD no Map<String, dynamic>
    pessoas.addAll(listaDeUtilizadores.pessoas);

    // Retorno a lista com os dados vindos da base de dados em JSON
    return pessoas;
  }

  //?_________________________________________Histórico da base de dados_________________________________________________________

  Future<Map<String, dynamic>> getObrasRequisitadasBD(
      DatabaseReference referenciaHistoricoBD) async {
    //
    HistoricoModel listaDeObrasRequisitadas;

    // Obter os dados de só uma vez da referencia do firebase na base de dados
    DatabaseEvent obrasRequisitadasBD = await referenciaHistoricoBD.once();

    Map<String, dynamic> respostaJSON =
        jsonDecode(jsonEncode(obrasRequisitadasBD.snapshot.value));

    listaDeObrasRequisitadas = HistoricoModel.fromJson(respostaJSON);

    obras.addAll(listaDeObrasRequisitadas.obrasRequisitadas);

    // Retorno a lista com os dados vindos da base de dados em JSON
    return obras;
  }

  //?_________________________________________Categorias da base de dados_________________________________________________________

  Future<List<Categoria>> getCategoriasBD(
      DatabaseReference referenciaLivrosBD) async {
    //
    CategoriaModel listaDeCategorias;

    DatabaseEvent dadosBD = await referenciaLivrosBD.once();

    List<dynamic> respostaJSON = jsonDecode(jsonEncode(dadosBD.snapshot.value));

    listaDeCategorias = CategoriaModel.fromJson(respostaJSON);

    categorias.addAll(listaDeCategorias.categorias);

    return categorias;
  }
}
