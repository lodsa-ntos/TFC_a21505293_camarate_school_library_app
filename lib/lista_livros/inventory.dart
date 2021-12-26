import 'dart:convert';

class Inventario {
  static List<RegisterBooks> books = [];

  // Obter os livros pelo número de registo
  RegisterBooks getById(int numRegisto) =>
      // ignore: null_closures
      books.firstWhere((element) => element.numRegisto == numRegisto,
          // ignore: null_closures
          orElse: null);

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
  final String disponibilidade;
  final num numEdicao;
  final String nomeColecao;
  final num numColecao;
  final num numVolume;
  final String cota;
  final String observacao;
  final String imagem;

  // Construtor
  RegisterBooks({
    // ignore: non_constant_identifier_names
    required this.numRegisto,
    // ignore: non_constant_identifier_names
    required this.ISBN,
    required this.titulo,
    required this.autor,
    required this.disponibilidade,
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
    String? disponibilidade,
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
      disponibilidade: disponibilidade ?? this.disponibilidade,
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
      'disponibilidade': disponibilidade,
      'numEdicao': numEdicao,
      'nomeColecao': nomeColecao,
      'numColecao': numColecao,
      'numVolume': numVolume,
      'cota': cota,
      'observacao': observacao,
      'imagem': imagem,
    };
  }

  factory RegisterBooks.fromMap(Map<String, dynamic> map) {
    return RegisterBooks(
      numRegisto: map['numRegisto']?.toInt() ?? 0,
      ISBN: map['ISBN'] ?? 0,
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      disponibilidade: map['disponibilidade'],
      numEdicao: map['numEdicao'] ?? 0,
      nomeColecao: map['nomeColecao'] ?? '',
      numColecao: map['numColecao'] ?? 0,
      numVolume: map['numVolume'] ?? 0,
      cota: map['cota'] ?? '',
      observacao: map['observacao'] ?? '',
      imagem: map['imagem'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterBooks.fromJson(String source) =>
      RegisterBooks.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegisterBooks(numRegisto: $numRegisto, ISBN: $ISBN, titulo: $titulo, autor: $autor, disponibilidade: $disponibilidade, numEdicao: $numEdicao, nomeColecao: $nomeColecao, numColecao: $numColecao, numVolume: $numVolume, cota: $cota, observacao: $observacao, imagem: $imagem)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterBooks &&
        other.numRegisto == numRegisto &&
        other.ISBN == ISBN &&
        other.titulo == titulo &&
        other.autor == autor &&
        other.disponibilidade == disponibilidade &&
        other.numEdicao == numEdicao &&
        other.nomeColecao == nomeColecao &&
        other.numColecao == numColecao &&
        other.numVolume == numVolume &&
        other.cota == cota &&
        other.observacao == observacao &&
        other.imagem == imagem;
  }

  @override
  int get hashCode {
    return numRegisto.hashCode ^
        ISBN.hashCode ^
        titulo.hashCode ^
        autor.hashCode ^
        disponibilidade.hashCode ^
        numEdicao.hashCode ^
        nomeColecao.hashCode ^
        numColecao.hashCode ^
        numVolume.hashCode ^
        cota.hashCode ^
        observacao.hashCode ^
        imagem.hashCode;
  }
}
