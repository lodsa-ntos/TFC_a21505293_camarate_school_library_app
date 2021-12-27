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

List<Emprestados> emps = [
  Emprestados(
      image: "assets/images/will_smith.jpg",
      title: "WILL",
      dataEntrega: "20/12/2021",
      percent: 50),
  Emprestados(
      image: "assets/images/guinness.jpg",
      title: "Guinness World Records 2021",
      dataEntrega: "15/12/2021",
      percent: 80),
  Emprestados(
      image: "assets/images/english_grammar.jpg",
      title: "English Grammar",
      dataEntrega: "03/12/2021",
      percent: 80),
];
