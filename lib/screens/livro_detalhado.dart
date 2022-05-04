import 'package:camarate_school_library/models/livro_model.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/utilizadores_model.dart';

/// Classe para apresentar os widgets que compoêm o formato para representarem
/// os detalhes dos livros
///
//! Alcançar a instancia da abse de dados para autenticação do utilizador atual
final _auth = FirebaseAuth.instance;

class LivroDetalhado extends StatelessWidget {
  const LivroDetalhado({Key? key, required this.livro}) : super(key: key);

  final Livro livro;

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
        builder: (context, requisitadoModel, child) {
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
                  livro.titulo.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),

                const SizedBox(height: 8),

                //** Autor */
                Text(
                  livro.autor.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  "ISBN: " + livro.isbn.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  "Editora: " + livro.editora.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  "Requisitado: " + livro.isRequisitado.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 16),

                //** Capa */
                SizedBox(
                  height: 350,
                  child: Image.network(livro.imagePath.toString()),
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
  final Livro livroARequisitar;

  const _BotaoRequisitar({required this.livroARequisitar, Key? key})
      : super(key: key);

  @override
  State<_BotaoRequisitar> createState() => _BotaoRequisitarState();
}

class _BotaoRequisitarState extends State<_BotaoRequisitar> {
  DatabaseReference? _referenciaParaRequisicao;
  DatabaseReference? _referenciaUID;

  // Utilizador atual que preencheu o formulário
  User? utilizador = _auth.currentUser;

  // Variável do tipo aluno para alcançar os atributos do aluno
  Livro teste = Livro();

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        //
        _referenciaParaRequisicao = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('isRequisitado');

        _referenciaUID = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('uidLivro');

        teste.uidLivro = utilizador!.uid;

        return Column(
          children: [
            Row(
              children: [
                // REQUISITAR
                ElevatedButton(
                  ///
                  child:
                      const Text('Requisitar', style: TextStyle(fontSize: 16)),

                  onPressed: widget.livroARequisitar.isRequisitado!
                      ? null
                      : () async {
                          // Fica requisitado

                          setState(() {
                            _referenciaParaRequisicao?.set(true);

                            _referenciaUID?.set(teste.uidLivro);

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
                    child:
                        const Text('Devolver', style: TextStyle(fontSize: 16)),

                    // Fica devolvido
                    onPressed: widget.livroARequisitar.isRequisitado! &&
                            teste.uidLivro!.contains(utilizador!.uid)
                        ? () async {
                            setState(() {
                              // Gravar ou atualiza dados de um caminho definido
                              _referenciaParaRequisicao?.set(false);
                              widget.livroARequisitar.isRequisitado = false;

                              requisitadoModel.devolverLivroRequisitado(
                                  widget.livroARequisitar);
                              print('Livro devolvido');
                            });
                          }
                        : null),
              ],
            ),

            const SizedBox(height: 12),

            //* SUCESSO
            Row(
              children: [
                Text(
                  widget.livroARequisitar.isRequisitado!
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
