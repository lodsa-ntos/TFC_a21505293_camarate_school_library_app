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
  bool isDisponivel;

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
    required this.isDisponivel,
  });

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is LivroModel && other.id == id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'isbn': isbn,
      'editora': editora,
      'imagePath': imagePath,
      'data': data.millisecondsSinceEpoch,
      'ano': ano,
      'isRequisitado': isRequisitado,
      'isDisponivel': isDisponivel,
    };
  }

  factory LivroModel.fromJson(key, Map dados) {
    return LivroModel(
      id: dados['id']?.toInt() ?? 0,
      titulo: dados['titulo'] ?? '',
      autor: dados['autor'] ?? '',
      isbn: dados['isbn'] ?? '',
      editora: dados['editora'] ?? '',
      imagePath: dados['imagePath'] ?? '',
      data: DateTime.fromMillisecondsSinceEpoch(dados['data']),
      ano: dados['ano']?.toInt() ?? 0,
      isRequisitado: dados['isRequisitado'] ?? false,
      isDisponivel: dados['isDisponivel'] ?? false,
    );
  }

  factory LivroModel.fromMap(Map<dynamic, dynamic> map) {
    return LivroModel(
      id: map['id']?.toInt() ?? 0,
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      isbn: map['isbn'] ?? '',
      editora: map['editora'] ?? '',
      imagePath: map['imagePath'] ?? '',
      data: DateTime.fromMillisecondsSinceEpoch(map['data']),
      ano: map['ano']?.toInt() ?? 0,
      isRequisitado: map['isRequisitado'] ?? false,
      isDisponivel: map['isDisponivel'] ?? false,
    );
  }
}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
