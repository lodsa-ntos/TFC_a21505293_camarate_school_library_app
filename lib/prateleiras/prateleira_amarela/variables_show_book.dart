class DadosListaAmarela {
  static List<DadosListaAmarela> livrosNasPrateleiras = [
    DadosListaAmarela(
      numRegistoShelf: 1,
      imagem:
          'https://images-na.ssl-images-amazon.com/images/I/81blQVIfQwL.jpg',
      tituloLivro: "A estrada do futuro",
      autor: "Bill Gates",
      disponibilidade: "Disponível",
      descricao: "",
    ),
    DadosListaAmarela(
      numRegistoShelf: 2,
      imagem:
          'https://images-na.ssl-images-amazon.com/images/I/41fJkUBmrdS._SX343_BO1,204,203,200_.jpg',
      tituloLivro: "English Thesaurus",
      autor: "Jane Austin",
      disponibilidade: "Disponível",
      descricao: "",
    ),
    DadosListaAmarela(
      numRegistoShelf: 3,
      imagem:
          'https://img.wook.pt/images/informatica-na-educacao-roger-maia/MXwyMzcwNzQwMXwxOTcwNTY3MnwxNTc2MTk1MjAwMDAw/175x',
      tituloLivro: "Informática na educação",
      autor: "Roger Maia",
      disponibilidade: "Esgotado",
      descricao: "",
    ),
    DadosListaAmarela(
      numRegistoShelf: 4,
      imagem:
          'https://images-na.ssl-images-amazon.com/images/I/61JosO2tkdL.jpg',
      tituloLivro: "Orgulho e Preconceito",
      autor: "Jane Austen",
      disponibilidade: "Disponível",
      descricao: "",
    ),
    DadosListaAmarela(
      numRegistoShelf: 5,
      imagem:
          'https://collectionapi.metmuseum.org/api/collection/v1/iiif/716639/1635046/main-image',
      tituloLivro: "Encyclopédie",
      autor: "Raymond Murphy",
      disponibilidade: "Esgotado",
      descricao: "",
    ),
  ];

  int numRegistoShelf;
  String tituloLivro;
  String autor;
  String disponibilidade;
  String descricao;
  String imagem;

  DadosListaAmarela({
    required this.numRegistoShelf,
    required this.tituloLivro,
    required this.autor,
    required this.disponibilidade,
    required this.descricao,
    required this.imagem,
  });
}
