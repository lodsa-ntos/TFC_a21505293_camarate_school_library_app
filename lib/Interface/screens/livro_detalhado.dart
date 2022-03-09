import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/View_models/repositorio_livros_requisitados.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LivroDetalhado extends StatelessWidget {
  //Se um construtor pode ser invocado como const para produzir uma instância
  //canonizada, é preferível fazê-lo.
  const LivroDetalhado({Key? key, required this.livro}) : super(key: key);

  final Livro livro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          livro.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              livro.autor,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "ISBN: " + livro.isbn,
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              "Editora: " + livro.editora,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 350,
              child: Image.network(livro.imagePath),
            ),
            const SizedBox(
              height: 12,
            ),
            _BotaoRequisitar(requisitarLivro: livro)
          ],
        ),
      ),
    );
  }
}

class _BotaoRequisitar extends StatelessWidget {
  final Livro requisitarLivro;

  const _BotaoRequisitar({required this.requisitarLivro, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Um pequeno tema para o texto(titulo, subTitulo, etc)
    var textTheme = Theme.of(context).textTheme.headline6;

    // O método context.select() permitirá ver as alterações de
    // uma *parte* do modelo. Defini uma função que "seleciona" (ou seja, retorna)
    // a parte que interessa e o pacote do providor não será reconstruído
    // este widget, a menos que essa parte específica do modelo seja alterada.
    //
    // Isso pode levar a melhorias significativas de desempenho.
    var isInHistorico = context.select<RepositorioLivrosRequisitados, bool>(
      // Aqui, apenas interessa saber se o [livro] está ou não no historico.
      (hist) => hist.livros.contains(requisitarLivro),
    );

    return TextButton(
      onPressed: isInHistorico
          ? null
          : () {
              // Se o livro não estiver no histórico, deixo o utilizador adicioná-lo.
              // O context.read(), aqui retorna uma chamada
              // e é executado sempre que o utilizador pressiona o botão de requisitar.
              // Em outras palavras, o context.read() é executado fora do método build.
              var historicoRequisicao =
                  context.read<RepositorioLivrosRequisitados>();
              historicoRequisicao.add(requisitarLivro);
              requisitarLivro.isRequisitado = true;
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Adiar para o padrão do widget.
        }),
      ),
      child: isInHistorico
          ? const Icon(Icons.check, semanticLabel: 'Adicionado ao historico')
          : Text(
              'Requisitar',
              style: textTheme,
            ),
    );
  }
}
