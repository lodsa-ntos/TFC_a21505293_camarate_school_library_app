import 'dart:convert';

import 'package:camarate_school_library/models/utilizadores_model.dart';

class RepositorioDeLivros {
  List<LivroModel> livroModel;

  RepositorioDeLivros({
    required this.livroModel,
  });

  factory RepositorioDeLivros.fromJSON(List<dynamic> json) {
    return RepositorioDeLivros(livroModel: verificarLivros(json));
  }

  static List<LivroModel> verificarLivros(livroJSON) {
    /// jsonEncode tranforma os dados JSON em string
    /// jsonDecode descodifica os dados e coloca no formato de Lista dynamic

    /// Obter os dados da base de dados e guardar num formato de uma
    ///  lista dinamica
    List<dynamic> isLivro = jsonDecode(jsonEncode(livroJSON));

    List<LivroModel> listaDeLivros =
        isLivro.map((dados) => LivroModel.fromJson(dados)).toList();

    return listaDeLivros;
  }

  /// Obter os livros pelo id
  LivroModel getPorId(String id) {
    return livroModel.firstWhere((element) => element.id == id);
  }
}

class LivroModel {
  final String id;
  final String titulo;
  final String autor;
  final String isbn;
  final String editora;
  final String imagePath;
  final String numRegisto;
  final int ano;
  bool isRequisitado;
  // colocar uid para saber que está requisitado

  LivroModel({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.isbn,
    required this.editora,
    required this.imagePath,
    required this.numRegisto,
    required this.ano,
    required this.isRequisitado,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["id"] = id;
    map["titulo"] = titulo;
    map["autor"] = autor;
    map["isbn"] = isbn;
    map["editora"] = editora;
    map["imagePath"] = imagePath;
    map["numRegisto"] = numRegisto;
    map["ano"] = ano;
    map["isRequisitado"] = isRequisitado;

    return map;
  }

  factory LivroModel.fromJson(Map<String, dynamic> json) {
    return LivroModel(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      autor: json['autor'] ?? '',
      isbn: json['isbn'] ?? '',
      editora: json['editora'] ?? '',
      imagePath: json['imagePath'] ?? '',
      numRegisto: json['numRegisto'] ?? '',
      ano: json['ano']?.toInt() ?? 0,
      isRequisitado: json['isRequisitado'] ?? false,
    );
  }
}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
