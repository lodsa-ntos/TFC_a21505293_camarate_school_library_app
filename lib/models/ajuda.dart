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
      Ajuda('O número máximo de livros a requisitar é 2 documentos.'),
    ],
  ),
  Ajuda(
    'Quando concluir a requisição na aplicação como obtenho o livro ?',
    <Ajuda>[
      Ajuda(
        'Após a requisição deve dirigir-se a biblioteca da escola para poder levantar o livro.',
      ),
    ],
  ),
  Ajuda(
    'Qual é o prazo máximo para devolução de um livro ?',
    <Ajuda>[
      Ajuda('O prazo de devolução dos livros é de 10 dias úteis.'),
    ],
  ),
  Ajuda(
    'Como pesquisar o livro pelo nome do autor ?',
    <Ajuda>[
      Ajuda(
        'Ao entrar na página de pesquisa, abaixo da caixa de pesquisa, seleciona o filtro de autor, para poder fazer a pesquisar pelo nome do autor.',
      ),
    ],
  ),
  Ajuda(
    'Como funciona a renovação de um livro após devolução ?',
    <Ajuda>[
      Ajuda(
        'O empréstimo só pode ser renovado mais uma vez por período igual ao primeiro.',
      ),
    ],
  ),
  Ajuda(
    'O que acontece caso o livro não seja devolvido, sofra perda ou dano ?',
    <Ajuda>[
      Ajuda(
        'A não devolução, perda ou dano implica a interdição de empréstimos até a sua devolução e  o pagamento do valor comercial do livro ou a entrega de um exemplar do mesmo.',
      ),
    ],
  ),
];
