import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/View_models/home_requisitar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

//** Classe para apresentar os widgets que compoêm o formato para representarem
//** os detalhes dos livros */

class LivroDetalhado extends StatelessWidget {
  const LivroDetalhado({Key? key, required this.livro}) : super(key: key);

  final Livro livro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //** Titulo do livro na barra */
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
            //** Autor */
            Text(livro.autor,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0)),

            const SizedBox(height: 8),

            Text(
              "ISBN: " + livro.isbn,
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              "Editora: " + livro.editora,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            //** Capa */
            SizedBox(
              height: 350,
              child: Image.network(livro.imagePath),
            ),

            const SizedBox(height: 12),

            //*  _Botão Requisitar */
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
      builder: (context, HomeRequisitarProvider historicoRequisicao, child) =>
          ElevatedButton(
        //** Se o livro está disponivel... */
        onPressed: requisitarLivro.isDisponivel
            ? () {
                //** Aidiciona-mos o livro na lista de livros requisitados */
                historicoRequisicao.addLivroRequisitado(requisitarLivro);

                //** fica requisitado */
                requisitarLivro.isRequisitado = true;
                //** Deixa de estar disponível */
                requisitarLivro.isDisponivel = false;
              }

            //** Aqui o botão fica desabilitado */
            : null,

        //** Se o livro foi requisitado  */
        child: requisitarLivro.isRequisitado

            //** O botão é transformado no icon check */
            ? const Icon(Icons.check, semanticLabel: 'Livro requisitado')
            : const Text(
                'Requisitar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}
