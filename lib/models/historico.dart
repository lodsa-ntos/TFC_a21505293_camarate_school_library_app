import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class HistoricoModel {
  Map<String, dynamic> obrasRequisitadas;

  HistoricoModel({
    required this.obrasRequisitadas,
  });

  factory HistoricoModel.fromJson(Map<String, dynamic> json) {
    return HistoricoModel(obrasRequisitadas: verificarObrasRequisitadas(json));
  }

  static Map<String, dynamic> verificarObrasRequisitadas(obrasJSON) {
    /// jsonEncode tranforma os dados JSON em string
    /// jsonDecode descodifica os dados e coloca no formato de Lista dynamic

    /// Obter os dados da base de dados e guardar num formato de uma
    /// lista dinamica
    Map<String, dynamic> isObraRequisitada = jsonDecode(jsonEncode(obrasJSON));

    final _historico = Historico.fromJson(isObraRequisitada);

    return _historico.toJson();
  }
}

class Historico {
  String? idLivro;
  String? dataRequisicao;
  String? requisitante;
  String? tituloLivro;
  String? uidRequisitante;
  String? dataEntrega;
  String? id;

  Historico({
    this.idLivro,
    this.dataRequisicao,
    this.requisitante,
    this.tituloLivro,
    this.uidRequisitante,
    this.dataEntrega,
    this.id,
  });

  // Transformar os dados da Pessoa num mapa de pares chave/valor.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosHistorico = <String, dynamic>{};
    dadosHistorico["idLivro"] = idLivro;
    dadosHistorico["dataRequisicao"] = dataRequisicao;
    dadosHistorico["requisitante"] = requisitante;
    dadosHistorico["tituloLivro"] = tituloLivro;
    dadosHistorico["uidRequisitante"] = uidRequisitante;
    dadosHistorico["dataEntrega"] = dataEntrega;
    dadosHistorico["id"] = id;

    return dadosHistorico;
  }

  // Receber dados do firebase e convertê-los num mapa de pares chave/valor com informação da Pessoa
  factory Historico.fromJson(Map<String, dynamic> json) {
    return Historico(
      idLivro: json['idLivro'] ?? '',
      dataRequisicao: json['dataRequisicao'] ?? '',
      requisitante: json['requisitante'] ?? '',
      tituloLivro: json['tituloLivro'] ?? '',
      uidRequisitante: json['uidRequisitante'] ?? '',
      dataEntrega: json['dataEntrega'] ?? '',
      id: json['id'] ?? '',
    );
  }

  factory Historico.fromSnapshot(DataSnapshot snapshot) {
    return Historico(
      id: snapshot.key!,
      dataRequisicao: (snapshot.value as Map)['dataRequisicao'],
      requisitante: (snapshot.value as Map)['requisitante'],
      tituloLivro: (snapshot.value as Map)['tituloLivro'],
      uidRequisitante: (snapshot.value as Map)['uidRequisitante'],
      dataEntrega: (snapshot.value as Map)['dataEntrega'],
    );
  }
}
