import 'dart:convert';

class DadosListaAmarela {
  static List<PrateleirasDaBiblioteca> livrosNasPrateleiras = [];

// Obter os livros pelo número de registo
  PrateleirasDaBiblioteca getById(int numRegisto) =>
      // ignore: null_closures
      livrosNasPrateleiras.firstWhere(
          (element) => element.numRegisto == numRegisto,
          // ignore: null_closures
          orElse: null);

  // Obter livros por posição
  PrateleirasDaBiblioteca getByPosition(int pos) => livrosNasPrateleiras[pos];
}

class PrateleirasDaBiblioteca {
  int numRegisto;
  String titulo;
  String autor;
  String disponibilidade;
  String descricao;
  String imagem;

  PrateleirasDaBiblioteca({
    required this.numRegisto,
    required this.titulo,
    required this.autor,
    required this.disponibilidade,
    required this.descricao,
    required this.imagem,
  });

  PrateleirasDaBiblioteca copyWith({
    int? numRegisto,
    String? titulo,
    String? autor,
    String? disponibilidade,
    String? descricao,
    String? imagem,
  }) {
    return PrateleirasDaBiblioteca(
      numRegisto: numRegisto ?? this.numRegisto,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      disponibilidade: disponibilidade ?? this.disponibilidade,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numRegisto': numRegisto,
      'titulo': titulo,
      'autor': autor,
      'disponibilidade': disponibilidade,
      'descricao': descricao,
      'imagem': imagem,
    };
  }

  factory PrateleirasDaBiblioteca.fromMap(Map<String, dynamic> map) {
    return PrateleirasDaBiblioteca(
      numRegisto: map['numRegisto']?.toInt() ?? 0,
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      disponibilidade: map['disponibilidade'] ?? '',
      descricao: map['descricao'] ?? '',
      imagem: map['imagem'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PrateleirasDaBiblioteca.fromJson(String source) =>
      PrateleirasDaBiblioteca.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrateleirasDaBiblioteca(numRegisto: $numRegisto, titulo: $titulo, autor: $autor, disponibilidade: $disponibilidade, descricao: $descricao, imagem: $imagem)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrateleirasDaBiblioteca &&
        other.numRegisto == numRegisto &&
        other.titulo == titulo &&
        other.autor == autor &&
        other.disponibilidade == disponibilidade &&
        other.descricao == descricao &&
        other.imagem == imagem;
  }

  @override
  int get hashCode {
    return numRegisto.hashCode ^
        titulo.hashCode ^
        autor.hashCode ^
        disponibilidade.hashCode ^
        descricao.hashCode ^
        imagem.hashCode;
  }
}
