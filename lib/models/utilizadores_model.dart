class AlunoModel {
  final int numCartaoAluno;
  final String primeiroNomeAluno;
  final String segundoNomeAluno;
  final int numAluno;
  final int ano;
  final String turma;
  final String emailAluno;
  final String passwordAluno;

  // Construtor
  AlunoModel({
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
      numCartaoAluno: json['numCartaoAluno'] ?? 0,
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

class ProfessorModel {
  final int numCartaoProf;
  final String primeiroNomeProf;
  final String segundoNomeProf;
  final String turma;
  final String emailProf;
  final String passwordProf;

  // Construtor
  ProfessorModel({
    required this.numCartaoProf,
    required this.primeiroNomeProf,
    required this.segundoNomeProf,
    required this.turma,
    required this.emailProf,
    required this.passwordProf,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosAluno = <String, dynamic>{};
    dadosAluno["numCartaoProf"] = numCartaoProf;
    dadosAluno["primeiroNomeProf"] = primeiroNomeProf;
    dadosAluno["segundoNomeProf"] = segundoNomeProf;
    dadosAluno["turma"] = turma;
    dadosAluno["emailProf"] = emailProf;
    dadosAluno["passwordProf"] = passwordProf;

    return dadosAluno;
  }

  factory ProfessorModel.fromJson(Map<String, dynamic> json) {
    return ProfessorModel(
      numCartaoProf: json['numCartaoProf'] ?? 0,
      primeiroNomeProf: json['primeiroNomeProf'] ?? '',
      segundoNomeProf: json['segundoNomeProf'] ?? '',
      turma: json['turma'] ?? '',
      emailProf: json['emailProf'] ?? '',
      passwordProf: json['passwordProf'] ?? '',
    );
  }
}

class FuncionarioModel {
  final int numCartaoFunc;
  final String primeiroNomeFunc;
  final String segundoNomeFunc;
  final String emailFunc;
  final String passwordFunc;

  // Construtor
  FuncionarioModel({
    required this.numCartaoFunc,
    required this.primeiroNomeFunc,
    required this.segundoNomeFunc,
    required this.emailFunc,
    required this.passwordFunc,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosAluno = <String, dynamic>{};
    dadosAluno["numCartaoFunc"] = numCartaoFunc;
    dadosAluno["primeiroNomeFunc"] = primeiroNomeFunc;
    dadosAluno["segundoNomeFunc"] = segundoNomeFunc;
    dadosAluno["emailFunc"] = emailFunc;
    dadosAluno["passwordFunc"] = passwordFunc;

    return dadosAluno;
  }

  factory FuncionarioModel.fromJson(Map<String, dynamic> json) {
    return FuncionarioModel(
      numCartaoFunc: json['numCartaoFunc'] ?? 0,
      primeiroNomeFunc: json['primeiroNomeFunc'] ?? '',
      segundoNomeFunc: json['segundoNomeFunc'] ?? '',
      emailFunc: json['emailFunc'] ?? '',
      passwordFunc: json['passwordFunc'] ?? '',
    );
  }
}
