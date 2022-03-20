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
}

List menuDoFiltro = [
  'Todos',
  'Autor',
  'Titulo',
  'Ano de publicação',
];
