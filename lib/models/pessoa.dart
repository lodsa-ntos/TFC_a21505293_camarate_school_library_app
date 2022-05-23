import 'dart:convert';

class PessoaModel {
  List<Pessoa> pessoas;

  PessoaModel({
    required this.pessoas,
  });

  factory PessoaModel.fromJson(String json) {
    return PessoaModel(pessoas: verificarLivros(json));
  }

  static List<Pessoa> verificarLivros(livroJSON) {
    /// jsonEncode tranforma os dados JSON em string
    /// jsonDecode descodifica os dados e coloca no formato de Lista dynamic

    /// Obter os dados da base de dados e guardar num formato de uma
    ///  lista dinamica
    String isPessoa = jsonDecode(jsonEncode(livroJSON));

    List<Pessoa> listaDePessoas =
        isPessoa.map((dados) => Pessoa.fromJson(dados)).toList();

    return listaDePessoas;
  }
}

class Pessoa {
  // Atributos
  String? uidPessoa;
  String? numCartaoPessoa;
  String? nomeCompletoPessoa;
  String? numPessoa;
  String? ano;
  String? turma;
  String? emailPessoa;
  String? passwordPessoa;

  // Construtor
  Pessoa({
    this.uidPessoa,
    this.numCartaoPessoa,
    this.nomeCompletoPessoa,
    this.numPessoa,
    this.ano,
    this.turma,
    this.emailPessoa,
    this.passwordPessoa,
  });

  // Transformar os dados da Pessoa num mapa de pares chave/valor.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosPessoa = <String, dynamic>{};
    dadosPessoa["uidPessoa"] = uidPessoa;
    dadosPessoa["numCartaoPessoa"] = numCartaoPessoa;
    dadosPessoa["nomeCompletoPessoa"] = nomeCompletoPessoa;
    dadosPessoa["numPessoa"] = numPessoa;
    dadosPessoa["ano"] = ano;
    dadosPessoa["turma"] = turma;
    dadosPessoa["emailPessoa"] = emailPessoa;
    dadosPessoa["passwordPessoa"] = passwordPessoa;

    return dadosPessoa;
  }

  // Receber dados do firebase e convertê-los num mapa de pares chave/valor com informação da Pessoa
  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      uidPessoa: json['uidPessoa'] ?? '',
      numCartaoPessoa: json['numCartaoPessoa'] ?? '',
      nomeCompletoPessoa: json['nomeCompletoPessoa'] ?? '',
      numPessoa: json['numPessoa'] ?? '',
      ano: json['ano'] ?? '',
      turma: json['turma'] ?? '',
      emailPessoa: json['emailPessoa'] ?? '',
      passwordPessoa: json['passwordPessoa'] ?? '',
    );
  }
}
