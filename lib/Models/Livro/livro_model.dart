import 'dart:convert';

class RepositorioDeLivros {
  List<LivroModel> livroModel;

  RepositorioDeLivros({
    required this.livroModel,
  });

  factory RepositorioDeLivros.fromJSON(List<dynamic> json) {
    return RepositorioDeLivros(livroModel: verificarLivros(json));
  }

  static List<LivroModel> verificarLivros(livroJSON) {
    //
    List<dynamic> isLivro = jsonDecode(jsonEncode(livroJSON));

    List<LivroModel> listaDeLivros =
        isLivro.map((dados) => LivroModel.fromJson(dados)).toList();

    return listaDeLivros;
  }

  //** */ Obter os livros pelo id
  LivroModel getPorId(String id) =>

      /// Aqui, a lista de livros é infinita, vai fazer um loop sobre [gerarLivrosAleatorios].
      /// O que é errado para o que se quer....
      livroModel.firstWhere((element) => element.id == id);
}

class LivroModel {
  final String id;
  final String titulo;
  final String autor;
  final String isbn;
  final String editora;
  final String imagePath;
  final int ano;
  bool isRequisitado;

  LivroModel({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.isbn,
    required this.editora,
    required this.imagePath,
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
