import 'dart:convert';

import 'dados_livros_requisitados.dart';

class DadosListaAmarela {
  int numRegisto;
  String titulo;
  String autor;
  String disponibilidade;
  String descricao;
  String imagem;
  List<DadosLivrosRequisitados> requisitados = [];

  DadosListaAmarela({
    required this.numRegisto,
    required this.titulo,
    required this.autor,
    required this.disponibilidade,
    required this.descricao,
    required this.imagem,
    required this.requisitados,
  });

  Map<String, dynamic> toMap() {
    return {
      'numRegisto': numRegisto,
      'titulo': titulo,
      'autor': autor,
      'disponibilidade': disponibilidade,
      'descricao': descricao,
      'imagem': imagem,
      'requisitados': requisitados.map((x) => x.toMap()).toList(),
    };
  }

  factory DadosListaAmarela.fromMap(Map<String, dynamic> map) {
    return DadosListaAmarela(
      numRegisto: map['numRegisto']?.toInt() ?? 0,
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      disponibilidade: map['disponibilidade'] ?? '',
      descricao: map['descricao'] ?? '',
      imagem: map['imagem'] ?? '',
      requisitados: List<DadosLivrosRequisitados>.from(
          map['requisitados']?.map((x) => DadosLivrosRequisitados.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DadosListaAmarela.fromJson(String source) =>
      DadosListaAmarela.fromMap(json.decode(source));
}

List<DadosListaAmarela> dadosListaAmarela = [
  DadosListaAmarela(
    numRegisto: 1,
    titulo: "A estrada do futuro",
    autor: "Bill Gates",
    disponibilidade: "Disponível",
    descricao: "descricao",
    imagem: "https://images-na.ssl-images-amazon.com/images/I/81blQVIfQwL.jpg",
    requisitados: [],
  ),
  DadosListaAmarela(
    numRegisto: 2,
    titulo: "Livro do Desassossego | Vol.II",
    autor: "Fernando Pessoa",
    disponibilidade: "Disponível",
    descricao: "descricao",
    imagem:
        "https://cdn.shopify.com/s/files/1/0450/0717/5837/products/image-1_0645e650-6119-4245-bff4-b13847982f82_1024x1024.jpg?v=1614103731",
    requisitados: [],
  ),
  DadosListaAmarela(
    numRegisto: 3,
    titulo: "O Eu profundo e os outros Eus",
    autor: "Fernando Pessoa",
    disponibilidade: "Disponível",
    descricao: "descricao",
    imagem:
        "https://blog.estantevirtual.com.br/wp-content/uploads/fernandopessoa-euprofundoeoutroseus.jpg",
    requisitados: [],
  ),
  DadosListaAmarela(
    numRegisto: 4,
    titulo: "Luís De Camões",
    autor: "J. M. Latino Coelho",
    disponibilidade: "Esgotado",
    descricao: "descricao",
    imagem:
        "http://www.livrosusados.pt/wp-content/uploads/2016/03/figuras-do-passado-luis-de-camoes.jpg",
    requisitados: [],
  ),
  DadosListaAmarela(
    numRegisto: 5,
    titulo: "Um perito em busca da verdade",
    autor: "Ana Maria Magalhães & Isabel Alçada",
    disponibilidade: "Esgotado",
    descricao: "descricao",
    imagem: "https://oriscoespreita.sapo.pt/imagens/perito_verdade.png",
    requisitados: [],
  ),
  DadosListaAmarela(
    numRegisto: 6,
    titulo: "Talvez uma App",
    autor: "Ana Maria Magalhães & Isabel Alçada",
    disponibilidade: "Disponível",
    descricao: "descricao",
    imagem: "https://oriscoespreita.sapo.pt/imagens/talvez_app.png",
    requisitados: [],
  ),
];

List<DadosLivrosRequisitados> requisitados = [];
