import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Models/livros_requisitados_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import, implementation_imports
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
        //** Titulo do livro */
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

            const SizedBox(height: 8),

            if (livro.isRequisitado == true) ...[
              const Text(
                'requisitado',
                style: TextStyle(color: Colors.indigo),
              ),
            ],

            const SizedBox(height: 12),

            //*  _Botão Requisitar */
            _BotaoRequisitar(livroARequisitar: livro)
          ],
        ),
      ),
    );
  }
}

class _BotaoRequisitar extends StatelessWidget {
  final Livro livroARequisitar;

  const _BotaoRequisitar({required this.livroARequisitar, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //** Consumer */
    return Consumer<LivrosRequisitadosModel>(
      builder: (context, LivrosRequisitadosModel historicoRequisicao, child) =>
          ElevatedButton(
        //** Se o livro está disponivel... */
        onPressed: livroARequisitar.isDisponivel
            ? () {
                //** Aidiciona-mos o livro na lista de livros requisitados */
                historicoRequisicao.addLivroRequisitado(livroARequisitar);

                //** fica requisitado */
                livroARequisitar.isRequisitado = true;
                //** Deixa de estar disponível */
                livroARequisitar.isDisponivel = false;
              }

            //** Aqui o botão fica desabilitado */
            : null,

        //** Se o livro foi requisitado  */
        child: livroARequisitar.isRequisitado

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
