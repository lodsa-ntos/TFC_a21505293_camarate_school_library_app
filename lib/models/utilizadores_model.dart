//? Alunos
class AlunoModel {
  String? uidAluno;
  String? numCartaoAluno;
  String? nomeCompletoAluno;
  String? nomeUtilizadorAluno;
  int? numAluno;
  String? ano;
  String? turma;
  String? emailAluno;
  String? passwordAluno;

  // Construtor AlunoModel
  AlunoModel({
    this.uidAluno,
    this.numCartaoAluno,
    this.nomeCompletoAluno,
    this.nomeUtilizadorAluno,
    this.numAluno,
    this.ano,
    this.turma,
    this.emailAluno,
    this.passwordAluno,
  });

  // Enviar dados para o firebase
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosAluno = <String, dynamic>{};
    dadosAluno["uidAluno"] = uidAluno;
    dadosAluno["numCartaoAluno"] = numCartaoAluno;
    dadosAluno["nomeCompletoAluno"] = nomeCompletoAluno;
    dadosAluno["nomeUtilizadorAluno"] = nomeUtilizadorAluno;
    dadosAluno["numAluno"] = numAluno;
    dadosAluno["ano"] = ano;
    dadosAluno["turma"] = turma;
    dadosAluno["emailAluno"] = emailAluno;
    dadosAluno["passwordAluno"] = passwordAluno;

    return dadosAluno;
  }

  // Receber dados do firebase
  factory AlunoModel.fromJson(Map<String, dynamic> json) {
    return AlunoModel(
      uidAluno: json['uidAluno'] ?? '',
      numCartaoAluno: json['numCartaoAluno'] ?? 'a1234',
      nomeCompletoAluno: json['nomeCompletoAluno'] ?? '',
      nomeUtilizadorAluno: json['nomeUtilizadorAluno'] ?? '',
      numAluno: json['numAluno'] ?? '',
      ano: json['ano'] ?? '',
      turma: json['turma'] ?? '',
      emailAluno: json['emailAluno'] ?? '',
      passwordAluno: json['passwordAluno'] ?? '',
    );
  }
}

//* Professores
class ProfessorModel {
  String? uidProf;
  String? numCartaoProf;
  String? nomeCompletoProf;
  String? turma;
  String? emailProf;
  String? passwordProf;

  // Construtor ProfessorModel
  ProfessorModel({
    this.uidProf,
    this.numCartaoProf,
    this.nomeCompletoProf,
    this.turma,
    this.emailProf,
    this.passwordProf,
  });

  // Enviar dados para o firebase
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosProf = <String, dynamic>{};
    dadosProf["uidProf"] = uidProf;
    dadosProf["numCartaoProf"] = numCartaoProf;
    dadosProf["primeiroNomeProf"] = nomeCompletoProf;
    dadosProf["turma"] = turma;
    dadosProf["emailProf"] = emailProf;
    dadosProf["passwordProf"] = passwordProf;

    return dadosProf;
  }

  // Receber dados do firebase
  factory ProfessorModel.fromJson(Map<String, dynamic> json) {
    return ProfessorModel(
      uidProf: json['uidProf'] ?? '',
      numCartaoProf: json['numCartaoProf'] ?? 'p1234',
      nomeCompletoProf: json['primeiroNomeProf'] ?? '',
      turma: json['turma'] ?? '',
      emailProf: json['emailProf'] ?? '',
      passwordProf: json['passwordProf'] ?? '',
    );
  }
}

//! Funcionario
class FuncionarioModel {
  final String uidFunc;
  final String numCartaoFunc;
  final String nomeCompletoFunc;
  final String emailFunc;
  final String passwordFunc;

  // Construtor FuncionarioModel
  FuncionarioModel({
    required this.uidFunc,
    required this.numCartaoFunc,
    required this.nomeCompletoFunc,
    required this.emailFunc,
    required this.passwordFunc,
  });

  // Enviar dados para o firebase
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosFunc = <String, dynamic>{};
    dadosFunc["uidFunc"] = uidFunc;
    dadosFunc["numCartaoFunc"] = numCartaoFunc;
    dadosFunc["primeiroNomeFunc"] = nomeCompletoFunc;
    dadosFunc["emailFunc"] = emailFunc;
    dadosFunc["passwordFunc"] = passwordFunc;

    return dadosFunc;
  }

  // Receber dados do firebase
  factory FuncionarioModel.fromJson(Map<String, dynamic> json) {
    return FuncionarioModel(
      uidFunc: json['uidFunc'] ?? '',
      numCartaoFunc: json['numCartaoFunc'] ?? 'f1234',
      nomeCompletoFunc: json['primeiroNomeFunc'] ?? '',
      emailFunc: json['emailFunc'] ?? '',
      passwordFunc: json['passwordFunc'] ?? '',
    );
  }
}
