import 'dart:convert';

class ListaDeLivros {
  List<LivroModel> livroModel;

  ListaDeLivros({
    required this.livroModel,
  });

  factory ListaDeLivros.fromJSON(List<dynamic> json) {
    return ListaDeLivros(livroModel: verificarLivros(json));
  }

  static List<LivroModel> verificarLivros(livroJSON) {
    //
    var isLivro = List<dynamic>.from(jsonDecode(livroJSON));

    List<LivroModel> listaDeLivros =
        isLivro.map((dados) => LivroModel.fromJson(dados)).toList();

    return listaDeLivros;
  }
}

class LivroModel {
  final int id;
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

  factory LivroModel.fromJson(Map<String, dynamic> json) {
    return LivroModel(
      id: json["_id"] ?? 0,
      titulo: json['titulo'] ?? '',
      autor: json['autor'] ?? '',
      isbn: json['isbn'] ?? '',
      editora: json['editora'] ?? '',
      imagePath: json['imagePath'] ?? '',
      data: DateTime.parse(json['data'] as String),
      ano: json['ano']?.toInt() ?? 0,
      isRequisitado: json['isRequisitado'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) map["_id"] = id;
    map["titulo"] = titulo;
    map["autor"] = autor;
    map["isbn"] = isbn;
    map["editora"] = editora;
    map["imagePath"] = imagePath;
    map["data"] = data;
    map["ano"] = ano;
    map["isRequisitado"] = isRequisitado;
    return map;
  }
}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
