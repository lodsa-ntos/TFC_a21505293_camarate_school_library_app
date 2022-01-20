import 'dart:convert';

class DadosListaAmarela {
  int numRegisto;
  String titulo;
  String autor;
  String disponibilidade;
  String descricao;
  String imagem;
  bool livroRequisitado;

  DadosListaAmarela({
    required this.numRegisto,
    required this.titulo,
    required this.autor,
    required this.disponibilidade,
    required this.descricao,
    required this.imagem,
    required this.livroRequisitado,
  });

  Map<String, dynamic> toMap() {
    return {
      'numRegisto': numRegisto,
      'titulo': titulo,
      'autor': autor,
      'disponibilidade': disponibilidade,
      'descricao': descricao,
      'imagem': imagem,
      'estaRequisitado': livroRequisitado,
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
      livroRequisitado: map['estaRequisitado'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DadosListaAmarela.fromJson(String source) =>
      DadosListaAmarela.fromMap(json.decode(source));

  DadosListaAmarela copyWith({
    int? numRegisto,
    String? titulo,
    String? autor,
    String? disponibilidade,
    String? descricao,
    String? imagem,
    bool? estaRequisitado,
  }) {
    return DadosListaAmarela(
      numRegisto: numRegisto ?? this.numRegisto,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      disponibilidade: disponibilidade ?? this.disponibilidade,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
      livroRequisitado: estaRequisitado ?? livroRequisitado,
    );
  }

  @override
  String toString() {
    return 'DadosListaAmarela(numRegisto: $numRegisto, titulo: $titulo, autor: $autor, disponibilidade: $disponibilidade, descricao: $descricao, imagem: $imagem, estaRequisitado: $livroRequisitado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DadosListaAmarela &&
        other.numRegisto == numRegisto &&
        other.titulo == titulo &&
        other.autor == autor &&
        other.disponibilidade == disponibilidade &&
        other.descricao == descricao &&
        other.imagem == imagem &&
        other.livroRequisitado == livroRequisitado;
  }

  @override
  int get hashCode {
    return numRegisto.hashCode ^
        titulo.hashCode ^
        autor.hashCode ^
        disponibilidade.hashCode ^
        descricao.hashCode ^
        imagem.hashCode ^
        livroRequisitado.hashCode;
  }
}

List<DadosListaAmarela> dadosListaAmarela = [
  DadosListaAmarela(
    numRegisto: 1,
    titulo: "A estrada do futuro",
    autor: "Bill Gates",
    disponibilidade: "Disponível",
    descricao:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    imagem: "https://images-na.ssl-images-amazon.com/images/I/81blQVIfQwL.jpg",
    livroRequisitado: false,
  ),
  DadosListaAmarela(
    numRegisto: 2,
    titulo: "Livro do Desassossego | Vol.II",
    autor: "Fernando Pessoa",
    disponibilidade: "Disponível",
    descricao:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    imagem:
        "https://cdn.shopify.com/s/files/1/0450/0717/5837/products/image-1_0645e650-6119-4245-bff4-b13847982f82_1024x1024.jpg?v=1614103731",
    livroRequisitado: false,
  ),
  DadosListaAmarela(
    numRegisto: 3,
    titulo: "O Eu profundo e os outros Eus",
    autor: "Fernando Pessoa",
    disponibilidade: "Disponível",
    descricao:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    imagem:
        "https://blog.estantevirtual.com.br/wp-content/uploads/fernandopessoa-euprofundoeoutroseus.jpg",
    livroRequisitado: false,
  ),
  DadosListaAmarela(
    numRegisto: 4,
    titulo: "Luís De Camões",
    autor: "J. M. Latino Coelho",
    disponibilidade: "Esgotado",
    descricao:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    imagem:
        "http://www.livrosusados.pt/wp-content/uploads/2016/03/figuras-do-passado-luis-de-camoes.jpg",
    livroRequisitado: false,
  ),
  DadosListaAmarela(
    numRegisto: 5,
    titulo: "Um perito em busca da verdade",
    autor: "Ana Maria Magalhães & Isabel Alçada",
    disponibilidade: "Esgotado",
    descricao:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    imagem: "https://oriscoespreita.sapo.pt/imagens/perito_verdade.png",
    livroRequisitado: false,
  ),
  DadosListaAmarela(
    numRegisto: 6,
    titulo: "Talvez uma App",
    autor: "Ana Maria Magalhães & Isabel Alçada",
    disponibilidade: "Disponível",
    descricao:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    imagem: "https://oriscoespreita.sapo.pt/imagens/talvez_app.png",
    livroRequisitado: false,
  ),
];
