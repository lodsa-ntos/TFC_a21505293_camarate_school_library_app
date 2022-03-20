import 'package:camarate_school_library/Components/filtrar_pesquisa.dart';

import 'livro.dart';

class RepositorioDeLivros {
  List<Livro> gerarTodosLivros = [
    Livro(
      id: 0,
      titulo: 'O Alquimista',
      autor: 'Paulo Coelho',
      editora: '11 X 17',
      isbn: '9789722524223',
      imagePath:
          'https://img.wook.pt/images/o-alquimista-paulo-coelho/MXwxNTIzNzEzOXwxMDcyNTQ3NXwxMzgzNTIzMjAwMDAwfHdlYnA=/502x',
      isRequisitado: false,
      isDisponivel: true,
      data: '15-03-2022 - 17:00',
      ano: 2013,
    ),
    Livro(
      id: 1,
      titulo: 'Que número é este',
      autor: 'Ricardo Garcia',
      editora: 'Fundação Francisco Manuel dos Santos',
      isbn: '9789898838889',
      imagePath:
          'https://img.wook.pt/images/que-numero-e-este-ricardo-garcia/MXwyNDAwNjIyNHwyMDA1MjUxN3wxNTg3NDIzNjAwMDAwfHdlYnA=/502x',
      isRequisitado: false,
      isDisponivel: true,
      data: '15-03-2022 - 17:00',
      ano: 2004,
    ),
    Livro(
      id: 2,
      titulo: '14 - Uma Vida nos Tectos do Mundo',
      autor: 'João Garcia',
      editora: 'Lua de Papel',
      isbn: '9789892326153',
      imagePath:
          'https://img.wook.pt/images/14-uma-vida-nos-tectos-do-mundo-joao-garcia/MXwxNTcyNDIwNXwxMTIxOTMwMnwxMzk4OTg1MjAwMDAwfHdlYnA=/502x',
      isRequisitado: false,
      isDisponivel: true,
      data: '15-03-2022 - 17:00',
      ano: 2002,
    ),
    Livro(
      id: 3,
      titulo: 'Planisfério Pessoal',
      autor: 'Gonçalo Cadilhe',
      editora: 'Clube do Autor',
      isbn: '9789897242915',
      imagePath:
          'https://img.wook.pt/images/planisferio-pessoal-goncalo-cadilhe/MXwxNzgxNzY4M3wxMzQ1ODk0NnwxNDYwNDE1NjAwMDAwfHdlYnA=/502x',
      isRequisitado: false,
      isDisponivel: true,
      data: '15-03-2022 - 17:00',
      ano: 1998,
    ),
  ];

  // Obter os livros pelo id
  Livro getPorId(int id) =>

      /// Aqui, a lista de livros é infinita, vai fazer um loop sobre [gerarLivrosAleatorios].
      /// O que é errado para o que se quer....
      gerarTodosLivros.firstWhere((element) => element.id == id);

  // Pesquisar livros
  List<Livro> pesquisarLivro(String condicaoDaPesquisa) {
    return gerarTodosLivros.where((livro) {
      return livro.titulo
          .toLowerCase()
          .contains(condicaoDaPesquisa.toLowerCase());
    }).toList();
  }

  /// Pesquisar livros por filtro
  filtrarPesquisa(String condicaoDaPesquisa) {
    if (condicaoDaPesquisa.isEmpty || selecionarFiltro == 0) {
      return gerarTodosLivros;
    } else if (selecionarFiltro == 1) {
      return gerarTodosLivros.where((livro) {
        return livro.autor
            .toString()
            .toLowerCase()
            .contains(condicaoDaPesquisa.toLowerCase());
      }).toList();
    } else if (selecionarFiltro == 2) {
      return gerarTodosLivros.where((livro) {
        return livro.titulo
            .toString()
            .toLowerCase()
            .contains(condicaoDaPesquisa.toLowerCase());
      }).toList();
    } else if (selecionarFiltro == 3) {
      return gerarTodosLivros.where((livro) {
        return livro.ano
            .toString()
            .toLowerCase()
            .contains(condicaoDaPesquisa.toLowerCase());
      }).toList();
    }
  }
}
