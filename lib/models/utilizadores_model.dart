import 'package:camarate_school_library/models/livro_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pessoa {
  // Atributos
  String? uidPessoa;
  String? numCartaoPessoa;
  String? nomeCompletoPessoa;
  String? nomeUtilizadorPessoa;
  int? numPessoa;
  String? ano;
  String? turma;
  String? emailPessoa;
  String? passwordPessoa;
  List<Livro>? livrosRequisitados;

  // Construtor
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
    this.livrosRequisitados,
  });

  // Construtor factory para criar uma Pessoa na base de dados Firestore do Firebase.
  factory Pessoa.fromSnapshot(DocumentSnapshot snapshot) {
    final novaPessoa = Pessoa.fromJson(snapshot.data() as Map<String, dynamic>);
    // Salvar o ID de referência para atualizar o documento no Firestore.
    novaPessoa.uidPessoa = snapshot.reference.id;
    return novaPessoa;
  }

  // Um construtor de factory para criar uma Pessoa a partir do JSON.
  factory Pessoa.fromJson(Map<String, dynamic> json) => pessoaFromJson(json);

  // Transformar os dados da Pessoa num mapa de pares chave/valor.
  Map<String, dynamic> toJson() => pessoaToJson(this);

  @override
  String toString() => 'Pessoa <$nomeCompletoPessoa>';
}

// Converter uma lista de mapas numa lista de livros.
List<Livro> _converterLivros(List<dynamic> livrosRequisitados) {
  final livrosRequisitados = <Livro>[];

  for (final livro in livrosRequisitados) {
    livrosRequisitados.add(Livro.fromJson(livro as Map<String, dynamic>));
  }
  return livrosRequisitados;
}

// Converter os livros requisitados numa lista de valores mapeados.
List<Map<String, dynamic>>? _listaLivrosRequisitados(List<Livro>? livros) {
  if (livros == null) {
    return null;
  }
  final mapLivro = <Map<String, dynamic>>[];
  // ignore: avoid_function_literals_in_foreach_calls
  livros.forEach((livro) {
    mapLivro.add(livro.toJson());
  });
  return mapLivro;
}

// Enviar dados para o firebase
Map<String, dynamic> pessoaToJson(Pessoa dadosPessoa) => <String, dynamic>{
      'uidPessoa': dadosPessoa.uidPessoa,
      'numCartaoPessoa': dadosPessoa.numCartaoPessoa,
      'nomeCompletoPessoa': dadosPessoa.nomeCompletoPessoa,
      'nomeUtilizadorPessoa': dadosPessoa.nomeUtilizadorPessoa,
      'numPessoa': dadosPessoa.numPessoa,
      'ano': dadosPessoa.ano,
      'turma': dadosPessoa.turma,
      'emailPessoa': dadosPessoa.emailPessoa,
      'passwordPessoa': dadosPessoa.passwordPessoa,
      'livrosRequisitadosPessoa':
          _listaLivrosRequisitados(dadosPessoa.livrosRequisitados),
    };

// Receber dados do firebase e convertê-los num mapa de pares chave/valor com informação da Pessoa
Pessoa pessoaFromJson(Map<String, dynamic> json) {
  return Pessoa(
    uidPessoa: json['uidPessoa'] ?? '',
    numCartaoPessoa: json['numCartaoPessoa'] ?? '',
    nomeCompletoPessoa: json['nomeCompletoPessoa'] ?? '',
    nomeUtilizadorPessoa: json['nomeUtilizadorPessoa'] ?? '',
    numPessoa: json['numPessoa'] ?? '',
    ano: json['ano'] ?? '',
    turma: json['turma'] ?? '',
    emailPessoa: json['emailPessoa'] ?? '',
    passwordPessoa: json['passwordPessoa'] ?? '',
    livrosRequisitados:
        _converterLivros(json['livrosRequisitados'] as List<dynamic>),
  );
}
