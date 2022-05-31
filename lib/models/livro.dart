import 'dart:convert';

class LivroModel {
  List<Livro> livros;

  LivroModel({
    required this.livros,
  });

  factory LivroModel.fromJson(List<dynamic> json) {
    return LivroModel(livros: verificarLivros(json));
  }

  static List<Livro> verificarLivros(livroJSON) {
    /// jsonEncode tranforma os dados JSON em string
    /// jsonDecode descodifica os dados e coloca no formato de Lista dynamic

    /// Obter os dados da base de dados e guardar num formato de uma
    /// lista dinamica
    List<dynamic> isLivro = jsonDecode(jsonEncode(livroJSON));

    List<Livro> listaDeLivros =
        isLivro.map((dados) => Livro.fromJson(dados)).toList();

    return listaDeLivros;
  }
}

class Livro {
  String? id;
  String? titulo;
  String? autor;
  String? isbn;
  String? editora;
  String? imagePath;
  String? numRegisto;
  int? ano;
  bool? isRequisitado;
  String? dataRequisicao;
  String? dataEntrega;
  String? uidLivro;
  String? numColecao;
  int? contarVezesRequisitadas;

  Livro({
    this.id,
    this.titulo,
    this.autor,
    this.isbn,
    this.editora,
    this.imagePath,
    this.numRegisto,
    this.ano,
    this.isRequisitado,
    this.dataRequisicao,
    this.dataEntrega,
    this.uidLivro,
    this.numColecao,
    this.contarVezesRequisitadas,
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
    map["dataRequisicao"] = dataRequisicao;
    map["dataEntrega"] = dataEntrega;
    map["uidLivro"] = uidLivro;
    map["numColecao"] = numColecao;
    map["contarVezesRequisitadas"] = contarVezesRequisitadas;

    return map;
  }

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      autor: json['autor'] ?? '',
      isbn: json['isbn'] ?? '',
      editora: json['editora'] ?? '',
      imagePath: json['imagePath'] ?? '',
      numRegisto: json['numRegisto'] ?? '',
      ano: json['ano']?.toInt() ?? 0,
      isRequisitado: json['isRequisitado'] ?? false,
      dataRequisicao: json['dataRequisicao'] ?? '',
      dataEntrega: json['dataEntrega'] ?? '',
      uidLivro: json['uidLivro'] ?? '',
      numColecao: json['numColecao'] ?? '',
      contarVezesRequisitadas: json['contarVezesRequisitadas'] ?? 0,
    );
  }
}

List<dynamic> menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
