class Ajuda {
  final String titulo;
  final List<Ajuda> listaDeAjudas;

  Ajuda(
    this.titulo, [
    this.listaDeAjudas = const <Ajuda>[],
  ]);
}

final List<Ajuda> perguntasERespostas = <Ajuda>[
  Ajuda(
    'Quantos livros podem ser requisitados ?',
    <Ajuda>[
      Ajuda(
          'Todos os livros podem ser requisitados para leres em casa, com a exceção dos que estão assinalados com uma bolinha verde.'),
    ],
  ),
  Ajuda(
    'Quando concluir a requisição na aplicação como obtenho o livro ?',
    <Ajuda>[
      Ajuda(
          'Após a requisição deve derijir-se a biblioteca da escola para poder levantar o livro'),
    ],
  ),
  Ajuda(
    'Qual é o prazo máximo para devolução de um livro ?',
    <Ajuda>[
      Ajuda('O prazo de devolução dos livros é de 10 dias.'),
    ],
  ),
  Ajuda(
    'Como pesquisar o livro pelo nome do autor ?',
    <Ajuda>[
      Ajuda(
          'Ao entrar na página de pesquisa, abaixo da caixa de pesquisa, seleciona o filtro de autor, para poder fazer a pesquisar pelo nome do autor.'),
    ],
  ),
];
