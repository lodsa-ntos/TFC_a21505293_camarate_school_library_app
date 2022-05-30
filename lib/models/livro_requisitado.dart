import 'dart:convert';

class LivroRequisitadoModelBD {
  Map<String, dynamic> requisitados;

  LivroRequisitadoModelBD({
    required this.requisitados,
  });

  factory LivroRequisitadoModelBD.fromJson(Map<String, dynamic> json) {
    return LivroRequisitadoModelBD(
        requisitados: verificarLivrosRequisitados(json));
  }

  static Map<String, dynamic> verificarLivrosRequisitados(requisitadoJSON) {
    /// jsonEncode tranforma os dados JSON em string
    /// jsonDecode descodifica os dados e coloca no formato de Lista dynamic

    /// Obter os dados da base de dados e guardar num formato de uma
    /// lista dinamica
    Map<String, dynamic> isLivrosRequisitados =
        jsonDecode(jsonEncode(requisitadoJSON));

    final _isRequisitado = LivroRequisitado.fromJson(isLivrosRequisitados);

    return _isRequisitado.toJson();
  }
}

class LivroRequisitado {
  String? idDoLivro;
  String? capa;
  String? tituloDoLivro;
  String? dataDeEntrega;
  String? uidRequisicao;
  String? estado;

  LivroRequisitado({
    this.idDoLivro,
    this.capa,
    this.tituloDoLivro,
    this.dataDeEntrega,
    this.uidRequisicao,
    this.estado,
  });

  // Transformar os dados da Pessoa num mapa de pares chave/valor.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosRequisicao = <String, dynamic>{};
    dadosRequisicao["idDoLivro"] = idDoLivro;
    dadosRequisicao["capa"] = capa;
    dadosRequisicao["tituloDoLivro"] = tituloDoLivro;
    dadosRequisicao["dataDeEntrega"] = dataDeEntrega;
    dadosRequisicao["uidRequisicao"] = uidRequisicao;
    dadosRequisicao["estado"] = estado;

    return dadosRequisicao;
  }

  // Receber dados do firebase e convertê-los num mapa de pares chave/valor com informação da Pessoa
  factory LivroRequisitado.fromJson(Map<String, dynamic> json) {
    return LivroRequisitado(
      idDoLivro: json['idDoLivro'] ?? '',
      capa: json['capa'] ?? '',
      tituloDoLivro: json['tituloDoLivro'] ?? '',
      dataDeEntrega: json['dataDeEntrega'] ?? '',
      uidRequisicao: json['uidRequisicao'] ?? '',
      estado: json['estado'] ?? '',
    );
  }
}
