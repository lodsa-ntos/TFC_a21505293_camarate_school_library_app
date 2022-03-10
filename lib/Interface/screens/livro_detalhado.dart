import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/View_models/home_provider.dart';
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
            /*
             *  _Botão Requisitar */
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
    var isInHistorico = context.select<HomeProvider, bool>(
      // Aqui, apenas interessa saber se o [livro] está ou não no historico.
      (hist) => hist.livros.contains(requisitarLivro),
    );

    return ElevatedButton(
      onPressed: isInHistorico
          ? null
          : () {
              // Se o livro não estiver no histórico, deixo o utilizador adicioná-lo.
              // O context.read(), aqui retorna uma chamada
              // e é executado sempre que o utilizador pressiona o botão de requisitar.
              // Em outras palavras, o context.read() é executado fora do método build.
              var historicoRequisicao = context.read<HomeProvider>();
              historicoRequisicao.add(requisitarLivro);
              requisitarLivro.isRequisitado = true;
              const SnackBar(
                  content: Text("Redirecting to payment gateway..."));
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
          : const Text(
              'Requisitar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
    );
  }
}
