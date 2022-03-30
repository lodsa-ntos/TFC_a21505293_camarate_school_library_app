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

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.

}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Título',
  'Ano de publicação',
];
