import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Models/livro_requisitado_model.dart';
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
    var requisicao = context.read<LivroRequisitadoModel>();
    var devolucao = context.watch<LivroRequisitadoModel>();

    return Column(
      children: [
        Row(
          children: [
            //* Requisitar
            ElevatedButton(
              child: const Text('Requisitar', style: TextStyle(fontSize: 16)),
              onPressed: livroARequisitar.isRequisitado
                  //* Se foi requisitado, o botão requisitar vai estar desativado
                  ? null
                  //* Se não foi requisitado
                  : () {
                      //** Aidiciona-mos o livro na lista de livros requisitados */
                      requisicao.addLivroRequisitado(livroARequisitar);

                      //** Fica requisitado */
                      livroARequisitar.isRequisitado = true;
                      //** Deixa de estar disponível */
                      livroARequisitar.isDisponivel = false;
                    },
            ),

            //* Distanciar botôes
            const SizedBox(width: 35),

            //* Devolver
            ElevatedButton(
              child: const Text('Devolver', style: TextStyle(fontSize: 16)),
              //* Se foi requisitado
              onPressed: livroARequisitar.isRequisitado
                  ? () {
                      devolucao.devolverLivroRequisitado(livroARequisitar);
                      //** Fica devolvido */
                      livroARequisitar.isRequisitado = false;
                      //** Fica disponível */
                      livroARequisitar.isDisponivel = true;
                    }
                  //* Se não foi requisitado, o botão devolver vai estar desativado
                  : null,
            ),
          ],
        ),

        //* Distanciar botôes
        const SizedBox(height: 12),

        //* SUCESSO
        Row(
          children: [
            Text(
              livroARequisitar.isRequisitado ? 'Livro requisitado...' : '',
              style: const TextStyle(color: Colors.green, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
