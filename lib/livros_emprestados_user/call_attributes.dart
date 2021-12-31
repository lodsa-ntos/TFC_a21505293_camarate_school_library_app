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
    title: "Orgulho",
    autor: "Jane Austin",
    dataEntrega: "15/12/2021",
  ),
  Emprestados(
    image: 'https://m.media-amazon.com/images/I/41AZkNhLyeL._SL500_.jpg',
    title: "English",
    autor: "Raymond Murphy",
    dataEntrega: "20/12/2021",
  ),
  Emprestados(
    image:
        'https://img.wook.pt/images/livro-de-fichas-top-matematica-2-ano-antonio-jose-mota/MXwxODk0NTQ0OXwyMTQ3MjU3MXwxNjExNzA1NjAwMDAw/500x',
    title: "Livro de fichas",
    autor:
        "António José Mota | Eva Lima | Fátima Patronilho | Maria Manuel Santos | Nuno Barrigão | Nuno Pedroso",
    dataEntrega: "28/12/2021",
  ),
];
