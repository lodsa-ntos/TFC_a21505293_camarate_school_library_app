import 'dart:convert';

class CategoriaModel {
  List<Categoria> categorias;

  CategoriaModel({
    required this.categorias,
  });

  factory CategoriaModel.fromJson(List<dynamic> json) {
    return CategoriaModel(categorias: verificarLivros(json));
  }

  static List<Categoria> verificarLivros(categoriaJSON) {
    /// jsonEncode tranforma os dados JSON em string
    /// jsonDecode descodifica os dados e coloca no formato de Lista dynamic

    /// Obter os dados da base de dados e guardar num formato de uma
    /// lista dinamica
    List<dynamic> isCategoria = jsonDecode(jsonEncode(categoriaJSON));

    List<Categoria> listaDeCategorias = isCategoria
        .map((dados) => Categoria.fromJson(dados ?? <String, dynamic>{}))
        .toList();

    return listaDeCategorias;
  }
}

class Categoria {
  String? nome;
  String? classe;

  Categoria({this.nome, this.classe});

  // Transformar os dados da Pessoa num mapa de pares chave/valor.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dadosHistorico = <String, dynamic>{};
    dadosHistorico["nome"] = nome;
    dadosHistorico["classe"] = classe;

    return dadosHistorico;
  }

  // Receber dados do firebase e convertê-los num mapa de pares chave/valor com informação da Pessoa
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      nome: json['nome'] ?? '',
      classe: json['classe'] ?? '',
    );
  }
}
