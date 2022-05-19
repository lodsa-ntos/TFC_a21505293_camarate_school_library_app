//? Alunos
class Pessoa {
  String? uidPessoa;
  String? numCartaoPessoa;
  String? nomeCompletoPessoa;
  String? nomeUtilizadorPessoa;
  int? numPessoa;
  String? ano;
  String? turma;
  String? emailPessoa;
  String? passwordPessoa;

  // Construtor AlunoModel
  Pessoa({
    this.uidPessoa,
    this.numCartaoPessoa,
    this.nomeCompletoPessoa,
    this.nomeUtilizadorPessoa,
    this.numPessoa,
    this.ano,
    this.turma,
    this.emailPessoa,
    this.passwordPessoa,
  });

  // Enviar dados para o firebase
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosAluno = <String, dynamic>{};
    dadosAluno["uidPessoa"] = uidPessoa;
    dadosAluno["numCartaoPessoa"] = numCartaoPessoa;
    dadosAluno["nomeCompletoPessoa"] = nomeCompletoPessoa;
    dadosAluno["nomeUtilizadorPessoa"] = nomeUtilizadorPessoa;
    dadosAluno["numPessoa"] = numPessoa;
    dadosAluno["ano"] = ano;
    dadosAluno["turma"] = turma;
    dadosAluno["emailPessoa"] = emailPessoa;
    dadosAluno["passwordPessoa"] = passwordPessoa;

    return dadosAluno;
  }

  // Receber dados do firebase
  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      uidPessoa: json['uidPessoa'] ?? '',
      numCartaoPessoa: json['numCartaoPessoa'] ?? 'a1234',
      nomeCompletoPessoa: json['nomeCompletoPessoa'] ?? '',
      nomeUtilizadorPessoa: json['nomeUtilizadorPessoa'] ?? '',
      numPessoa: json['numPessoa'] ?? '',
      ano: json['ano'] ?? '',
      turma: json['turma'] ?? '',
      emailPessoa: json['emailPessoa'] ?? '',
      passwordPessoa: json['passwordPessoa'] ?? '',
    );
  }
}
