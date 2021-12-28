class Emprestados {
  final String title, image, dataEntrega;
  final int percent;

  Emprestados({
    required this.title,
    required this.image,
    required this.dataEntrega,
    required this.percent,
  });
}

List<Emprestados> livrosEmprestados = [
  Emprestados(
      image: 'https://www.easons.com/globalassets/book-covers/will-jacket.jpg',
      title: "WILL",
      dataEntrega: "20/12/2021",
      percent: 50),
  Emprestados(
      image: 'https://images-na.ssl-images-amazon.com/images/I/91wxQ9JbJ5L.jpg',
      title: "Guinness 2021",
      dataEntrega: "15/12/2021",
      percent: 80),
  Emprestados(
      image: 'https://m.media-amazon.com/images/I/41AZkNhLyeL._SL500_.jpg',
      title: "English Grammar ",
      dataEntrega: "03/12/2021",
      percent: 80),
];
