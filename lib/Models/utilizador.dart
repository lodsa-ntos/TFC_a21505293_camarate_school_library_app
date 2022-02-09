import 'dart:convert';

class Utilizador {
  String? uid;
  String? nomeProprio;
  String? ultimoNome;
  String? email;
  int? numAluno;
  String? turma;
  int? ano;
  String? nomeDiretorTurma;
  String? sobreMim;

  Utilizador({
    this.uid,
    this.nomeProprio,
    this.ultimoNome,
    this.email,
    this.numAluno,
    this.turma,
    this.ano,
    this.nomeDiretorTurma,
    this.sobreMim,
  });

  // Envia os dados para o servidor
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nomeProprio': nomeProprio,
      'ultimoNome': ultimoNome,
      'email': email,
      'numAluno': numAluno,
      'turma': turma,
      'ano': ano,
      'nomeDiretorTurma': nomeDiretorTurma,
      'sobreMim': sobreMim,
    };
  }

  // recebe os dados do servidor
  factory Utilizador.fromMap(map) {
    return Utilizador(
      uid: map['uid'],
      nomeProprio: map['nomeProprio'],
      ultimoNome: map['ultimoNome'],
      email: map['email'],
      numAluno: map['numAluno']?.toInt(),
      turma: map['turma'],
      ano: map['ano']?.toInt(),
      nomeDiretorTurma: map['nomeDiretorTurma'],
      sobreMim: map['sobreMim'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Utilizador.fromJson(String source) =>
      Utilizador.fromMap(json.decode(source));
}