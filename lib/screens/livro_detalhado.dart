import 'dart:async';

import 'package:camarate_school_library/Database/base_de_dados.dart';
import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:camarate_school_library/Models/Livro/livro_requisitado_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import, implementation_imports
import 'package:provider/src/provider.dart';

//** Classe para apresentar os widgets que compoêm o formato para representarem
//** os detalhes dos livros */

class LivroDetalhado extends StatelessWidget {
  const LivroDetalhado({Key? key, required this.livro}) : super(key: key);

  final LivroModel livro;

  @override
  Widget build(BuildContext context) {
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
              Text(livro.titulo,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0)),

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
  late final DatabaseReference _referenciaParaRequisicao;
  late StreamSubscription<DatabaseEvent> _estadoDaRequisicao;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _referenciaParaRequisicao = FirebaseDatabase.instance.ref(
      'livrosAleatorios/' +
          widget.livroARequisitar.id.toString() +
          '/isRequisitado',
    );

    try {
      final requisicaoNaBD = await _referenciaParaRequisicao.get();
      widget.livroARequisitar.isRequisitado = requisicaoNaBD.value as bool;
    } catch (e) {
      debugPrint(e.toString());
    }

    _estadoDaRequisicao =
        _referenciaParaRequisicao.onValue.listen((DatabaseEvent event) {
      setState(() {
        widget.livroARequisitar.isRequisitado =
            (event.snapshot.value ?? false) as bool;
      });
    });
  }

  fazerRequisicao() async {
    await _referenciaParaRequisicao.set(true);
    //widget.livroARequisitar.isRequisitado = true;
  }

  fazerDevolucao() async {
    await _referenciaParaRequisicao.set(false);
    //widget.livroARequisitar.isRequisitado = false;
  }

  @override
  void dispose() {
    _estadoDaRequisicao.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var requisicao = context.read<LivroRequisitadoModel>();
    var devolucao = context.watch<LivroRequisitadoModel>();

    return Column(
      children: [
        Row(
          children: [
            //* REQUISITAR
            ElevatedButton(
              child: const Text('Requisitar', style: TextStyle(fontSize: 16)),
              onPressed: widget.livroARequisitar.isRequisitado
                  //* Se foi requisitado, o botão requisitar vai estar desativado
                  ? null
                  //* Se não foi requisitado
                  : () {
                      //** Adiciona-mos o livro na lista de livros requisitados */
                      requisicao.addLivroRequisitado(widget.livroARequisitar);

                      //** Fica requisitado */
                      fazerRequisicao();
                    },
            ),

            //* Distanciar botões
            const SizedBox(width: 35),

            //* DEVOLVER
            ElevatedButton(
              child: const Text('Devolver', style: TextStyle(fontSize: 16)),
              //* Se foi requisitado
              onPressed: widget.livroARequisitar.isRequisitado
                  ? () {
                      devolucao
                          .devolverLivroRequisitado(widget.livroARequisitar);
                      //** Fica devolvido */
                      fazerDevolucao();
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
              widget.livroARequisitar.isRequisitado
                  ? 'Livro requisitado...'
                  : '',
              style: const TextStyle(color: Colors.green, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
