import 'dart:convert';

class DadosLivrosRequisitados {
  String titulo;
  String descricao;
  String dataEntrega;
  String imagem;

  DadosLivrosRequisitados({
    required this.titulo,
    required this.descricao,
    required this.dataEntrega,
    required this.imagem,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'dataEntrega': dataEntrega,
      'imagem': imagem,
    };
  }

  factory DadosLivrosRequisitados.fromMap(Map<String, dynamic> map) {
    return DadosLivrosRequisitados(
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      dataEntrega: map['dataEntrega'] ?? '',
      imagem: map['imagem'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DadosLivrosRequisitados.fromJson(String source) =>
      DadosLivrosRequisitados.fromMap(json.decode(source));
}

List<DadosLivrosRequisitados> requisitados = [
  DadosLivrosRequisitados(
    titulo: "A estrada do futuro",
    descricao:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    imagem: "https://images-na.ssl-images-amazon.com/images/I/81blQVIfQwL.jpg",
    dataEntrega: "12/01/2022",
  ),
];
