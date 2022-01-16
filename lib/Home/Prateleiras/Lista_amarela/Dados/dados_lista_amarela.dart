import 'dart:convert';

import 'dados_livros_requisitados.dart';

class DadosListaAmarela {
  int numRegisto;
  String titulo;
  String autor;
  String disponibilidade;
  String descricao;
  String imagem;
  List<ModeloLivrosRequisitados> requisitados = [];

  DadosListaAmarela({
    required this.numRegisto,
    required this.titulo,
    required this.autor,
    required this.disponibilidade,
    required this.descricao,
    required this.imagem,
    required this.requisitados,
  });

  Map<String, dynamic> toMap() {
    return {
      'numRegisto': numRegisto,
      'titulo': titulo,
      'autor': autor,
      'disponibilidade': disponibilidade,
      'descricao': descricao,
      'imagem': imagem,
      'requisitados': requisitados.map((x) => x.toMap()).toList(),
    };
  }

  factory DadosListaAmarela.fromMap(Map<String, dynamic> map) {
    return DadosListaAmarela(
      numRegisto: map['numRegisto']?.toInt() ?? 0,
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      disponibilidade: map['disponibilidade'] ?? '',
      descricao: map['descricao'] ?? '',
      imagem: map['imagem'] ?? '',
      requisitados: List<ModeloLivrosRequisitados>.from(
          map['requisitados']?.map((x) => ModeloLivrosRequisitados.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DadosListaAmarela.fromJson(String source) =>
      DadosListaAmarela.fromMap(json.decode(source));
}
