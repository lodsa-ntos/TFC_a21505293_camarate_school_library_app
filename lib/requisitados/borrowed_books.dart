class LivrosEmprestados {
  static List<LivrosEmprestados> listRequisicao = [];

  int numRegisto;
  String imagem;
  String titulo;
  String dataEntrega;

  LivrosEmprestados({
    required this.numRegisto,
    required this.imagem,
    required this.titulo,
    required this.dataEntrega,
  });
}
