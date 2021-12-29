class YellowClasse {
  final String image, title, autor;

  YellowClasse({
    required this.image,
    required this.title,
    required this.autor,
  });
}

List<YellowClasse> livrosClasseYellow = [
  YellowClasse(
    image:
        'https://img.wook.pt/images/deus-nao-precisa-de-ti-esther-maria-magnis/MXwxNTIzNjU0N3wxMDcyNDgyM3wxMzgzNTIzMjAwMDAw/500x',
    title: "Deus não precisa de ti",
    autor: "Esther Maria Magnis",
  ),
  YellowClasse(
    image:
        'https://images-na.ssl-images-amazon.com/images/I/41fJkUBmrdS._SX343_BO1,204,203,200_.jpg',
    title: "English Thesaurus",
    autor: "Jane Austin",
  ),
  YellowClasse(
    image:
        'https://img.wook.pt/images/informatica-na-educacao-roger-maia/MXwyMzcwNzQwMXwxOTcwNTY3MnwxNTc2MTk1MjAwMDAw/175x',
    title: "Informática na educação",
    autor: "Roger Maia",
  ),
  YellowClasse(
    image: 'https://images-na.ssl-images-amazon.com/images/I/81blQVIfQwL.jpg',
    title: "A estrada do futuro",
    autor: "Bill Gates",
  ),
  YellowClasse(
    image:
        'https://collectionapi.metmuseum.org/api/collection/v1/iiif/716639/1635046/main-image',
    title: "Encyclopédie",
    autor: "Raymond Murphy",
  ),
];
