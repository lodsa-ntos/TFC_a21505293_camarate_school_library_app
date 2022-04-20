import 'package:camarate_school_library/models/livro_model.dart';
import 'package:camarate_school_library/view_models/livro_requisitado_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

/// Classe para apresentar os widgets que compoêm o formato para representarem
/// os detalhes dos livros

class LivroDetalhado extends StatelessWidget {
  const LivroDetalhado({Key? key, required this.livro}) : super(key: key);

  final LivroModel livro;

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(builder: (BuildContext context,
        LivroRequisitadoModel requisitadoModel, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          //** Titulo do livro */
          title: const Text('Detalhe'), // Título
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //** Título */
                Text(
                  livro.titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),

                const SizedBox(height: 8),

                //** Autor */
                Text(
                  livro.autor,
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  "ISBN: " + livro.isbn,
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  "Editora: " + livro.editora,
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  "Disponível: " + livro.isRequisitado.toString(),
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
        ),
      );
    });
  }
}

class _BotaoRequisitar extends StatefulWidget {
  final LivroModel livroARequisitar;

  const _BotaoRequisitar({required this.livroARequisitar, Key? key})
      : super(key: key);

  @override
  State<_BotaoRequisitar> createState() => _BotaoRequisitarState();
}

class _BotaoRequisitarState extends State<_BotaoRequisitar> {
  DatabaseReference? _referenciaParaRequisicao;

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (BuildContext context, LivroRequisitadoModel requisitadoModel,
          Widget? child) {
        //
        _referenciaParaRequisicao = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id)
            .child('isRequisitado');

        return Column(
          children: [
            Row(
              children: [
                // REQUISITAR
                ElevatedButton(
                  ///
                  child:
                      const Text('Requisitar', style: TextStyle(fontSize: 16)),

                  onPressed: () async {
                    // Fica requisitado

                    setState(() {
                      _referenciaParaRequisicao?.set(true);
                      widget.livroARequisitar.isRequisitado = true;
                      requisitadoModel.addLivroRequisitado(
                        widget.livroARequisitar,
                      );
                      print('Livro requisitado');
                    });
                  },
                ),

                const SizedBox(width: 35),

                // DEVOLVER
                ElevatedButton(
                  ///
                  child: const Text('Devolver', style: TextStyle(fontSize: 16)),

                  // Fica devolvido
                  onPressed: () async {
                    setState(() {
                      _referenciaParaRequisicao?.set(false);
                      widget.livroARequisitar.isRequisitado = false;

                      requisitadoModel
                          .devolverLivroRequisitado(widget.livroARequisitar);
                      print('Livro devolvido');
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            //* SUCESSO
            Row(
              children: [
                Text(
                  widget.livroARequisitar.isRequisitado
                      ? 'Livro requisitado...'
                      : '',
                  style: const TextStyle(color: Colors.green, fontSize: 18),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
