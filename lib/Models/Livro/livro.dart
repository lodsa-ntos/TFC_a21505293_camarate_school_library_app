import 'dart:convert';

class Livro {
  final int id;
  final String titulo;
  final String autor;
  final String isbn;
  final String editora;
  final String imagePath;
  final String data;
  final int ano;
  bool isRequisitado;
  bool isDisponivel;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.isbn,
    required this.editora,
    required this.imagePath,
    required this.data,
    required this.ano,
    required this.isRequisitado,
    required this.isDisponivel,
  });

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Livro && other.id == id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'isbn': isbn,
      'editora': editora,
      'imagePath': imagePath,
      'data': data,
      'ano': ano,
      'isRequisitado': isRequisitado,
      'isDisponivel': isDisponivel,
    };
  }

  factory Livro.fromJson(Map<String, dynamic> map) {
    return Livro(
      id: map['id']?.toInt() ?? 0,
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      isbn: map['isbn'] ?? '',
      editora: map['editora'] ?? '',
      imagePath: map['imagePath'] ?? '',
      data: map['data'] ?? '',
      ano: map['ano']?.toInt() ?? 0,
      isRequisitado: map['isRequisitado'] ?? false,
      isDisponivel: map['isDisponivel'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());
}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
