class Emprestados {
  final String image, title, autor, dataEntrega;

  Emprestados({
    required this.image,
    required this.title,
    required this.autor,
    required this.dataEntrega,
  });
}

List<Emprestados> livrosEmprestados = [
  Emprestados(
    image: 'https://www.easons.com/globalassets/book-covers/will-jacket.jpg',
    title: "WILL",
    autor: "Will Smith",
    dataEntrega: "03/12/2021",
  ),
  Emprestados(
    image: 'https://images-na.ssl-images-amazon.com/images/I/A1nnf-d831L.jpg',
    title: "Orgulho e \npreconceito",
    autor: "Jane Austin",
    dataEntrega: "15/12/2021",
  ),
  Emprestados(
    image: 'https://m.media-amazon.com/images/I/41AZkNhLyeL._SL500_.jpg',
    title: "English\nGrammar",
    autor: "Raymond Murphy",
    dataEntrega: "20/12/2021",
  ),
];
