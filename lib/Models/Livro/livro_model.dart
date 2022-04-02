class ListaDeLivros {
  List<LivroModel> listaDeLivros;

  ListaDeLivros({
    required this.listaDeLivros,
  });

  factory ListaDeLivros.fromJSON(Map<dynamic, dynamic> json) {
    return ListaDeLivros(listaDeLivros: parserecipes(json));
  }

  static List<LivroModel> parserecipes(livroJSON) {
    var isLivro = livroJSON['procurarLivros'] as List;
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
      id: json['id']?.toInt() ?? 0,
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
}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
