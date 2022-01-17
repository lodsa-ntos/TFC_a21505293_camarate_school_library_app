import 'dart:convert';

class DadosLivrosRequisitados {
  String titulo;
  String descricao;
  String dataEntrega;
  String imagem;

  DadosLivrosRequisitados({
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

  factory DadosLivrosRequisitados.fromMap(Map<String, dynamic> map) {
    return DadosLivrosRequisitados(
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      dataEntrega: map['dataEntrega'] ?? '',
      imagem: map['imagem'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DadosLivrosRequisitados.fromJson(String source) =>
      DadosLivrosRequisitados.fromMap(json.decode(source));
}
