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
  final String descricao;
  final String imagemAutor;
  bool isDisponivel;
  bool isRequisitado;

  // Construtor
  Livro({
    required this.numRegisto,
    required this.titulo,
    required this.autor,
    required this.editora,
    required this.isbn,
    required this.imagemCapa,
    required this.descricao,
    required this.imagemAutor,
    required this.isDisponivel,
    required this.isRequisitado,
  });

  Map<String, dynamic> toMap() {
    return {
      'numRegisto': numRegisto,
      'titulo': titulo,
      'autor': autor,
      'editora': editora,
      'isbn': isbn,
      'imagemCapa': imagemCapa,
      'descricao': descricao,
      'imagemAutor': imagemAutor,
      'isDisponivel': isDisponivel,
      'isRequisitado': isRequisitado,
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
      descricao: map['descricao'] ?? '',
      imagemAutor: map['imagemAutor'] ?? '',
      isDisponivel: map['isDisponivel'] ?? false,
      isRequisitado: map['isRequisitado'] ?? false,
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
        other.descricao == descricao &&
        other.imagemAutor == imagemAutor &&
        other.isDisponivel == isDisponivel &&
        other.isRequisitado == isRequisitado;
  }

  @override
  int get hashCode {
    return numRegisto.hashCode ^
        titulo.hashCode ^
        autor.hashCode ^
        editora.hashCode ^
        isbn.hashCode ^
        imagemCapa.hashCode ^
        descricao.hashCode ^
        imagemAutor.hashCode ^
        isDisponivel.hashCode ^
        isRequisitado.hashCode;
  }

  @override
  String toString() {
    return 'Livro(numRegisto: $numRegisto, titulo: $titulo, autor: $autor, editora: $editora, isbn: $isbn, imagemCapa: $imagemCapa, descricao: $descricao, imagemAutor: $imagemAutor, isDisponivel: $isDisponivel, isRequisitado: $isRequisitado)';
  }

  Livro copyWith({
    int? numRegisto,
    String? titulo,
    String? autor,
    String? editora,
    String? isbn,
    String? imagemCapa,
    String? descricao,
    String? imagemAutor,
    bool? isDisponivel,
    bool? isRequisitado,
  }) {
    return Livro(
      numRegisto: numRegisto ?? this.numRegisto,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      editora: editora ?? this.editora,
      isbn: isbn ?? this.isbn,
      imagemCapa: imagemCapa ?? this.imagemCapa,
      descricao: descricao ?? this.descricao,
      imagemAutor: imagemAutor ?? this.imagemAutor,
      isDisponivel: isDisponivel ?? this.isDisponivel,
      isRequisitado: isRequisitado ?? this.isRequisitado,
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
      isDisponivel: true,
      descricao:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imagemAutor:
          'https://br.web.img3.acsta.net/pictures/21/08/12/15/16/2533433.jpg',
      isRequisitado: false,
    ),
    Livro(
      numRegisto: 1,
      titulo: 'Que número é este?',
      autor: 'Ricardo Garcia',
      editora: 'Fundação Francisco Manuel dos Santos',
      isbn: '9789898838889',
      imagemCapa:
          'https://img.wook.pt/images/que-numero-e-este-ricardo-garcia/MXwyNDAwNjIyNHwyMDA1MjUxN3wxNTg3NDIzNjAwMDAwfHdlYnA=/502x',
      isDisponivel: true,
      descricao:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imagemAutor:
          'https://imagens.publico.pt/imagens.aspx/737891?tp=UH&db=IMAGENS&type=JPG&w=334&h=334&act=cropResize',
      isRequisitado: false,
    ),
    Livro(
      numRegisto: 2,
      titulo: '14 - Uma Vida nos Tectos do Mundo',
      autor: 'João Garcia',
      editora: 'Lua de Papel',
      isbn: '9789892326153',
      imagemCapa:
          'https://img.wook.pt/images/14-uma-vida-nos-tectos-do-mundo-joao-garcia/MXwxNTcyNDIwNXwxMTIxOTMwMnwxMzk4OTg1MjAwMDAwfHdlYnA=/502x',
      isDisponivel: true,
      descricao:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imagemAutor:
          'https://imagens.publico.pt/imagens.aspx/274255?tp=UH&db=IMAGENS&type=JPG&share=1&o=BarraFacebook_Publico.png',
      isRequisitado: false,
    ),
    Livro(
      numRegisto: 3,
      titulo: 'Planisfério Pessoal',
      autor: 'Gonçalo\nCadilhe',
      editora: 'Clube do Autor',
      isbn: '9789897242915',
      imagemCapa:
          'https://img.wook.pt/images/planisferio-pessoal-goncalo-cadilhe/MXwxNzgxNzY4M3wxMzQ1ODk0NnwxNDYwNDE1NjAwMDAwfHdlYnA=/502x',
      isDisponivel: true,
      descricao:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imagemAutor:
          'https://images.trustinnews.pt/uploads/sites/5/2019/10/goncalo-cadilhe-2.png',
      isRequisitado: false,
    ),
  ];
}
