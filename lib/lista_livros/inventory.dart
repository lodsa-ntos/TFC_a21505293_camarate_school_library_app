import 'dart:convert';

class Inventario {
  static List<RegisterBooks> books = [
    RegisterBooks(
        numRegisto: 1,
        ISBN: 4234,
        titulo: 'POESIAS',
        autor: 'Fernando Pessoa',
        numEdicao: 2,
        nomeColecao: 'nomeColecao',
        numColecao: 7,
        numVolume: 6,
        cota: 'cota',
        observacao: 'observacao',
        imagem:
            'https://www.lpm.com.br/livros/Imagens/poesias___pocket_9788525405593_g.jpg'),
    RegisterBooks(
        numRegisto: 1,
        ISBN: 4234,
        titulo: 'Livro do Desassossego | Vol.II',
        autor: 'Fernando Pessoa',
        numEdicao: 2,
        nomeColecao: 'nomeColecao',
        numColecao: 7,
        numVolume: 6,
        cota: 'cota',
        observacao: 'observacao',
        imagem:
            'https://cdn.shopify.com/s/files/1/0450/0717/5837/products/image-1_0645e650-6119-4245-bff4-b13847982f82_1024x1024.jpg?v=1614103731')
  ];

  // Obter os livros pelo número de registo
  RegisterBooks getById(int id) =>
      // ignore: null_closures
      books.firstWhere((element) => element.numRegisto == id, orElse: null);

  // Obter livros por posição
  RegisterBooks getByPosition(int pos) => books[pos];
}

class RegisterBooks {
  // Variaveis
  final int numRegisto;
  // ignore: non_constant_identifier_names
  final num ISBN;
  final String titulo;
  final String autor;
  final num numEdicao;
  final String nomeColecao;
  final num numColecao;
  final num numVolume;
  final String cota;
  final String observacao;
  final String imagem;

  // Construtor
  RegisterBooks({
    required this.numRegisto,
    // ignore: non_constant_identifier_names
    required this.ISBN,
    required this.titulo,
    required this.autor,
    required this.numEdicao,
    required this.nomeColecao,
    required this.numColecao,
    required this.numVolume,
    required this.cota,
    required this.observacao,
    required this.imagem,
  });

  RegisterBooks copyWith({
    int? numRegisto,
    // ignore: non_constant_identifier_names
    num? ISBN,
    String? titulo,
    String? autor,
    num? numEdicao,
    String? nomeColecao,
    num? numColecao,
    num? numVolume,
    String? cota,
    String? observacao,
    String? imagem,
  }) {
    return RegisterBooks(
      numRegisto: numRegisto ?? this.numRegisto,
      ISBN: ISBN ?? this.ISBN,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      numEdicao: numEdicao ?? this.numEdicao,
      nomeColecao: nomeColecao ?? this.nomeColecao,
      numColecao: numColecao ?? this.numColecao,
      numVolume: numVolume ?? this.numVolume,
      cota: cota ?? this.cota,
      observacao: observacao ?? this.observacao,
      imagem: imagem ?? this.imagem,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numRegisto': numRegisto,
      'ISBN': ISBN,
      'titulo': titulo,
      'autor': autor,
      'numEdicao': numEdicao,
      'nomeColecao': nomeColecao,
      'numColecao': numColecao,
      'numVolume': numVolume,
      'cota': cota,
      'observacao': observacao,
      'imagem': imagem,
    };
  }

  // Devolve uma instância de um subtipo.
  factory RegisterBooks.fromMap(Map<String, dynamic> map) {
    // ignore: unnecessary_null_comparison
    if (map == null) {}

    return RegisterBooks(
      numRegisto: map['numRegisto'],
      ISBN: map['ISBN'],
      titulo: map['titulo'],
      autor: map['autor'],
      numEdicao: map['numEdicao'],
      nomeColecao: map['nomeColecao'],
      numColecao: map['numColecao'],
      numVolume: map['numVolume'],
      cota: map['cota'],
      observacao: map['observacao'],
      imagem: map['imagem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterBooks.fromJson(String source) =>
      RegisterBooks.fromMap(json.decode(source));

  // ToString
  @override
  String toString() {
    return 'RegisterBooks(numRegisto: $numRegisto, titulo: $titulo, autor: $autor, imagem: $imagem)';
  }

  @override
  // ignore: avoid_renaming_method_parameters
  bool operator ==(Object obj) {
    if (identical(this, obj)) return true;

    return obj is RegisterBooks &&
        obj.numRegisto == numRegisto &&
        obj.ISBN == ISBN &&
        obj.titulo == titulo &&
        obj.autor == autor &&
        obj.numEdicao == numEdicao &&
        obj.nomeColecao == nomeColecao &&
        obj.numColecao == numColecao &&
        obj.numVolume == numVolume &&
        obj.cota == cota &&
        obj.observacao == observacao &&
        obj.imagem == imagem;
  }

  // Devolve um código hash para um valor numérico.
  @override
  int get hashCode {
    return numRegisto.hashCode ^
        ISBN.hashCode ^
        titulo.hashCode ^
        autor.hashCode ^
        numEdicao.hashCode ^
        nomeColecao.hashCode ^
        numColecao.hashCode ^
        numVolume.hashCode ^
        cota.hashCode ^
        observacao.hashCode ^
        imagem.hashCode;
  }
}

// Edição --> Local | Editora | Data de publicação
class Edition {
  String local;
  String editora;
  DateTime dataPublicacao;

  // Construtor
  Edition({
    required this.local,
    required this.editora,
    required this.dataPublicacao,
  });

  Edition copyWith({
    String? local,
    String? editora,
    DateTime? dataPublicacao,
  }) {
    return Edition(
      local: local ?? this.local,
      editora: editora ?? this.editora,
      dataPublicacao: dataPublicacao ?? this.dataPublicacao,
    );
  }
}
