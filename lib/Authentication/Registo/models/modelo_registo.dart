class ModeloRegistoUtilizador {
  String? primeiroNome;
  String? ultimoNome;
  String? email;
  String? password;
  String? numeroAluno;
  String? anoTurma;
  String? diretorTurma;
  String? textoSobreUtilizador;

  ModeloRegistoUtilizador({
    this.primeiroNome,
    this.ultimoNome,
    this.email,
    this.password,
    this.numeroAluno,
    this.anoTurma,
    this.diretorTurma,
    this.textoSobreUtilizador,
  });

  ModeloRegistoUtilizador.fromJson(Map<String, dynamic> json) {
    primeiroNome = json['primeiroNome'];
    ultimoNome = json['ultimoNome'];
    email = json['email'];
    password = json['password'];
    numeroAluno = json['numeroAluno'];
    anoTurma = json['anoTurma'];
    diretorTurma = json['diretorTurma'];
    textoSobreUtilizador = json['textoSobreUtilizador'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['primeiroNome'] = primeiroNome;
    data['ultimoNome'] = ultimoNome;
    data['email'] = email;
    data['password'] = password;
    data['numeroAluno'] = numeroAluno;
    data['anoTurma'] = anoTurma;
    data['diretorTurma'] = diretorTurma;
    data['textoSobreUtilizador'] = textoSobreUtilizador;
    return data;
  }

  @override
  String toString() {
    return 'ModeloRegistoUtilizador(\n primeiroNome: $primeiroNome\n, ultimoNome: $ultimoNome\n, email: $email\n, password: $password\n, numeroAluno: $numeroAluno\n, anoTurma: $anoTurma\n, diretorTurma: $diretorTurma\n, textoSobreUtilizador: $textoSobreUtilizador\n)';
  }
}
