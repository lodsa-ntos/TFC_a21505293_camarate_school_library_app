import 'dart:convert';

class ModeloLivrosRequisitados {
  String titulo;
  String descricao;
  String dataEntrega;
  String imagem;

  ModeloLivrosRequisitados({
    required this.titulo,
    required this.descricao,
    required this.dataEntrega,
    required this.imagem,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'dataEntrega': dataEntrega,
      'imagem': imagem,
    };
  }

  factory ModeloLivrosRequisitados.fromMap(Map<String, dynamic> map) {
    return ModeloLivrosRequisitados(
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      dataEntrega: map['dataEntrega'] ?? '',
      imagem: map['imagem'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ModeloLivrosRequisitados.fromJson(String source) =>
      ModeloLivrosRequisitados.fromMap(json.decode(source));
}
