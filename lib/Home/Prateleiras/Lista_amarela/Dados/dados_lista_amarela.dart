import 'dados_livros_requisitados.dart';

class DadosListaAmarela {
  String titulo;
  String autor;
  String disponibilidade;
  String descricao;
  int numeroPagina;
  String imagem;
  List<ModeloLivrosRequisitados> requisitados = [];

  DadosListaAmarela({
    required this.titulo,
    required this.autor,
    required this.disponibilidade,
    required this.descricao,
    required this.numeroPagina,
    required this.imagem,
    required this.requisitados,
  });
}
