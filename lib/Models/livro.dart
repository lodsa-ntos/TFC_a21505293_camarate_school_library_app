import 'dart:convert';

class Livros {
  static List<Livro> livros = [];

  // Obter os livros pelo número de registo
  Livro getById(int numRegisto) =>
      // ignore: null_closures
      livros.firstWhere((element) => element.numRegisto == numRegisto,
          // ignore: null_closures
          orElse: null);

  // Obter livros por posição
  Livro getByPosition(int pos) => livros[pos];
}

class Livro {
  // Variaveis
  final int numRegisto;
  final String titulo;
  final String autor;
  final String editora;
  final String isbn;
  final String imagemCapa;
  String disponibilidade;
  final String descricao;

  // Construtor
  Livro({
    required this.numRegisto,
    required this.titulo,
    required this.autor,
    required this.editora,
    required this.isbn,
    required this.imagemCapa,
    required this.disponibilidade,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'numRegisto': numRegisto,
      'titulo': titulo,
      'autor': autor,
      'editora': editora,
      'isbn': isbn,
      'imagemCapa': imagemCapa,
      'disponibilidade': disponibilidade,
      'descricao': descricao,
    };
  }

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      numRegisto: map['numRegisto']?.toInt() ?? 0,
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      editora: map['editora'] ?? '',
      isbn: map['isbn'] ?? '',
      imagemCapa: map['imagemCapa'] ?? '',
      disponibilidade: map['disponibilidade'] ?? '',
      descricao: map['descricao'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Livro.fromJson(String source) => Livro.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Livro &&
        other.numRegisto == numRegisto &&
        other.titulo == titulo &&
        other.autor == autor &&
        other.editora == editora &&
        other.isbn == isbn &&
        other.imagemCapa == imagemCapa &&
        other.disponibilidade == disponibilidade &&
        other.descricao == descricao;
  }

  @override
  int get hashCode {
    return numRegisto.hashCode ^
        titulo.hashCode ^
        autor.hashCode ^
        editora.hashCode ^
        isbn.hashCode ^
        imagemCapa.hashCode ^
        disponibilidade.hashCode ^
        descricao.hashCode;
  }

  @override
  String toString() {
    return 'Livro(numRegisto: $numRegisto, titulo: $titulo, autor: $autor, editora: $editora, isbn: $isbn, imagemCapa: $imagemCapa, disponibilidade: $disponibilidade, descricao: $descricao)';
  }

  Livro copyWith({
    int? numRegisto,
    String? titulo,
    String? autor,
    String? editora,
    String? isbn,
    String? imagemCapa,
    String? disponibilidade,
    String? descricao,
  }) {
    return Livro(
      numRegisto: numRegisto ?? this.numRegisto,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      editora: editora ?? this.editora,
      isbn: isbn ?? this.isbn,
      imagemCapa: imagemCapa ?? this.imagemCapa,
      disponibilidade: disponibilidade ?? this.disponibilidade,
      descricao: descricao ?? this.descricao,
    );
  }
}

List<Livro> gerarLivrosAleatorios() {
  return [
    Livro(
      numRegisto: 0,
      titulo: 'O Alquimista',
      autor: 'Paulo Coelho',
      editora: '11 X 17',
      isbn: '9789722524223',
      imagemCapa:
          'https://img.wook.pt/images/o-alquimista-paulo-coelho/MXwxNTIzNzEzOXwxMDcyNTQ3NXwxMzgzNTIzMjAwMDAwfHdlYnA=/502x',
      disponibilidade: 'Disponível',
      descricao:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
    ),
    Livro(
      numRegisto: 1,
      titulo: 'Que número é este',
      autor: 'Ricardo Garcia, Luísa Barbosa e Maria João Valente Rosa',
      editora: 'Fundação Francisco Manuel dos Santos',
      isbn: '9789898838889',
      imagemCapa:
          'https://img.wook.pt/images/que-numero-e-este-ricardo-garcia/MXwyNDAwNjIyNHwyMDA1MjUxN3wxNTg3NDIzNjAwMDAwfHdlYnA=/502x',
      disponibilidade: 'Disponível',
      descricao:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
    ),
    Livro(
      numRegisto: 2,
      titulo: '14 - Uma Vida nos Tectos do Mundo',
      autor: 'João Garcia',
      editora: 'Lua de Papel',
      isbn: '9789892326153',
      imagemCapa:
          'https://img.wook.pt/images/14-uma-vida-nos-tectos-do-mundo-joao-garcia/MXwxNTcyNDIwNXwxMTIxOTMwMnwxMzk4OTg1MjAwMDAwfHdlYnA=/502x',
      disponibilidade: 'Esgostado',
      descricao:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
    ),
    Livro(
      numRegisto: 3,
      titulo: 'Planisfério Pessoal',
      autor: 'Gonçalo Cadilhe',
      editora: 'Clube do Autor',
      isbn: '9789897242915',
      imagemCapa:
          'https://img.wook.pt/images/planisferio-pessoal-goncalo-cadilhe/MXwxNzgxNzY4M3wxMzQ1ODk0NnwxNDYwNDE1NjAwMDAwfHdlYnA=/502x',
      disponibilidade: 'Esgotado',
      descricao:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
    ),
  ];
}
