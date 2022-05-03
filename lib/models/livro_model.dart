import 'dart:convert';

import 'package:camarate_school_library/models/utilizadores_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RepositorioDeLivros {
  List<LivroModel> livroModel;

  RepositorioDeLivros({
    required this.livroModel,
  });

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

  factory RepositorioDeLivros.fromJSON(List<dynamic> json) {
    return RepositorioDeLivros(livroModel: verificarLivros(json));
  }

  /// Obter os livros pelo id
  LivroModel getPorId(String id) {
    return livroModel.firstWhere((element) => element.id == id);
  }
}

class LivroModel {
  String? id;
  String? titulo;
  String? autor;
  String? isbn;
  String? editora;
  String? imagePath;
  String? numRegisto;
  int? ano;
  bool? isRequisitado;
  String? uid;
  DateTime? data;
  // colocar uid para saber que está requisitado

  LivroModel({
    this.id,
    this.titulo,
    this.autor,
    this.isbn,
    this.editora,
    this.imagePath,
    this.numRegisto,
    this.ano,
    this.isRequisitado,
    this.uid,
    this.data,
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
    map["uid"] = uid;
    map["data"] = data;

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
      uid: json['uid'] ?? '',
      data: json['data'] ?? DateTime.now(),
    );
  }
}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
