//? Alunos
class AlunoModel {
  final String uidAluno;
  final String numCartaoAluno;
  final String primeiroNomeAluno;
  final String segundoNomeAluno;
  final int numAluno;
  final int ano;
  final String turma;
  final String emailAluno;
  final String passwordAluno;

  // Construtor AlunoModel
  AlunoModel({
    required this.uidAluno,
    required this.numCartaoAluno,
    required this.primeiroNomeAluno,
    required this.segundoNomeAluno,
    required this.numAluno,
    required this.ano,
    required this.turma,
    required this.emailAluno,
    required this.passwordAluno,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosAluno = <String, dynamic>{};
    dadosAluno["uidAluno"] = uidAluno;
    dadosAluno["numCartaoAluno"] = numCartaoAluno;
    dadosAluno["primeiroNomeAluno"] = primeiroNomeAluno;
    dadosAluno["segundoNomeAluno"] = segundoNomeAluno;
    dadosAluno["numAluno"] = numAluno;
    dadosAluno["ano"] = ano;
    dadosAluno["turma"] = turma;
    dadosAluno["emailAluno"] = emailAluno;
    dadosAluno["passwordAluno"] = passwordAluno;

    return dadosAluno;
  }

  factory AlunoModel.fromJson(Map<String, dynamic> json) {
    return AlunoModel(
      uidAluno: json['uidAluno'] ?? '',
      numCartaoAluno: json['numCartaoAluno'] ?? 'a1234',
      primeiroNomeAluno: json['primeiroNomeAluno'] ?? '',
      segundoNomeAluno: json['segundoNomeAluno'] ?? '',
      numAluno: json['numAluno'] ?? '',
      ano: json['ano'] ?? 0,
      turma: json['turma'] ?? '',
      emailAluno: json['emailAluno'] ?? '',
      passwordAluno: json['passwordAluno'] ?? '',
    );
  }
}

//* Professores
class ProfessorModel {
  final String uidProf;
  final String numCartaoProf;
  final String primeiroNomeProf;
  final String segundoNomeProf;
  final String turma;
  final String emailProf;
  final String passwordProf;

  // Construtor ProfessorModel
  ProfessorModel({
    required this.uidProf,
    required this.numCartaoProf,
    required this.primeiroNomeProf,
    required this.segundoNomeProf,
    required this.turma,
    required this.emailProf,
    required this.passwordProf,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosProf = <String, dynamic>{};
    dadosProf["uidProf"] = uidProf;
    dadosProf["numCartaoProf"] = numCartaoProf;
    dadosProf["primeiroNomeProf"] = primeiroNomeProf;
    dadosProf["segundoNomeProf"] = segundoNomeProf;
    dadosProf["turma"] = turma;
    dadosProf["emailProf"] = emailProf;
    dadosProf["passwordProf"] = passwordProf;

    return dadosProf;
  }

  factory ProfessorModel.fromJson(Map<String, dynamic> json) {
    return ProfessorModel(
      uidProf: json['uidProf'] ?? '',
      numCartaoProf: json['numCartaoProf'] ?? 'p1234',
      primeiroNomeProf: json['primeiroNomeProf'] ?? '',
      segundoNomeProf: json['segundoNomeProf'] ?? '',
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
  final String primeiroNomeFunc;
  final String segundoNomeFunc;
  final String emailFunc;
  final String passwordFunc;

  // Construtor FuncionarioModel
  FuncionarioModel({
    required this.uidFunc,
    required this.numCartaoFunc,
    required this.primeiroNomeFunc,
    required this.segundoNomeFunc,
    required this.emailFunc,
    required this.passwordFunc,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosFunc = <String, dynamic>{};
    dadosFunc["uidFunc"] = uidFunc;
    dadosFunc["numCartaoFunc"] = numCartaoFunc;
    dadosFunc["primeiroNomeFunc"] = primeiroNomeFunc;
    dadosFunc["segundoNomeFunc"] = segundoNomeFunc;
    dadosFunc["emailFunc"] = emailFunc;
    dadosFunc["passwordFunc"] = passwordFunc;

    return dadosFunc;
  }

  factory FuncionarioModel.fromJson(Map<String, dynamic> json) {
    return FuncionarioModel(
      uidFunc: json['uidFunc'] ?? '',
      numCartaoFunc: json['numCartaoFunc'] ?? 'f1234',
      primeiroNomeFunc: json['primeiroNomeFunc'] ?? '',
      segundoNomeFunc: json['segundoNomeFunc'] ?? '',
      emailFunc: json['emailFunc'] ?? '',
      passwordFunc: json['passwordFunc'] ?? '',
    );
  }
}
