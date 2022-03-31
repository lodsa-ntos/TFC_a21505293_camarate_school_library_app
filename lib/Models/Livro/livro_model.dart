import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class LivroModel {
  late final int id;
  final String titulo;
  final String autor;
  final String isbn;
  final String editora;
  final String imagePath;
  final DateTime data;
  final int ano;
  bool isRequisitado;

  LivroModel({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.isbn,
    required this.editora,
    required this.imagePath,
    required this.data,
    required this.ano,
    required this.isRequisitado,
  });
}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
