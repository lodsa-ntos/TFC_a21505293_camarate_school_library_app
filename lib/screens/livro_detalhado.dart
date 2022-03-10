import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/View_models/home_requisitar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Consumer<HomeRequisitarProvider>(
      builder: (context, historicoRequisicao, child) => ElevatedButton(
        onPressed: requisitarLivro.isDisponivel
            ? () {
                historicoRequisicao.addLivroRequisitado(requisitarLivro);
                requisitarLivro.isRequisitado = true;
                requisitarLivro.isDisponivel = false;
              }
            : null,
        child: requisitarLivro.isRequisitado
            ? const Icon(Icons.check, semanticLabel: 'Adicionado ao historico')
            : const Text(
                'Requisitar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}
