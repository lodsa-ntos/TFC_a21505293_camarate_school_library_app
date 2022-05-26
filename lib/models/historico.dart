import 'dart:convert';

class Historico {
  String? idAleatorio;
  String? idLivro;
  int? numDeVezes;
  String? dataRequisicao;
  String? requisitante;
  String? tituloLivro;
  String? uidRequisitante;

  Historico({
    this.idAleatorio,
    this.idLivro,
    this.numDeVezes,
    this.dataRequisicao,
    this.requisitante,
    this.tituloLivro,
    this.uidRequisitante,
  });

  // Transformar os dados da Pessoa num mapa de pares chave/valor.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosHistorico = <String, dynamic>{};
    dadosHistorico["idAleatorio"] = idAleatorio;
    dadosHistorico["idLivro"] = idLivro;
    dadosHistorico["numDeVezes"] = numDeVezes;
    dadosHistorico["dataRequisicao"] = dataRequisicao;
    dadosHistorico["requisitante"] = requisitante;
    dadosHistorico["tituloLivro"] = tituloLivro;
    dadosHistorico["uidRequisitante"] = uidRequisitante;

    return dadosHistorico;
  }

  // Receber dados do firebase e convertê-los num mapa de pares chave/valor com informação da Pessoa
  factory Historico.fromJson(Map<String, dynamic> json) {
    return Historico(
      idAleatorio: json['idAleatorio'] ?? '',
      idLivro: json['idLivro'] ?? '',
      numDeVezes: json['numDeVezes'] ?? 0,
      dataRequisicao: json['dataRequisicao'] ?? '',
      requisitante: json['requisitante'] ?? '',
      tituloLivro: json['tituloLivro'] ?? '',
      uidRequisitante: json['uidRequisitante'] ?? '',
    );
  }
}

class HistoricoModel {
  List<Historico> obrasRequisitadas;

  HistoricoModel({
    required this.obrasRequisitadas,
  });

  factory HistoricoModel.fromJson(List<dynamic> json) {
    return HistoricoModel(obrasRequisitadas: verificarObrasRequisitadas(json));
  }

  static List<Historico> verificarObrasRequisitadas(obrasJSON) {
    /// jsonEncode tranforma os dados JSON em string
    /// jsonDecode descodifica os dados e coloca no formato de Lista dynamic

    /// Obter os dados da base de dados e guardar num formato de uma
    /// lista dinamica
    List<dynamic> isObraRequisitada = jsonDecode(jsonEncode(obrasJSON));

    List<Historico> listaDoHistorico =
        isObraRequisitada.map((dados) => Historico.fromJson(dados)).toList();

    return listaDoHistorico;
  }
}
