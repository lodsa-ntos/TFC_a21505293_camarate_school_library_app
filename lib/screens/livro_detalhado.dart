import 'package:camarate_school_library/models/livro_model.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // DateFormat

/// Classe para apresentar os widgets que compoêm o formato para representarem
/// os detalhes dos livros
///
//? Alcançar a instância da base de dados para autenticação do utilizador atual
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

class _BotaoRequisitarState extends State<_BotaoRequisitar> {
  DatabaseReference? _referenciaParaRequisicao;
  DatabaseReference? _referenciaUID;
  DatabaseReference? _referenciaDataRequisicao;
  DatabaseReference? _referenciaDataDevolucao;

  // Utilizador atual
  User? utilizador = _auth.currentUser;

  // Variável do tipo Livro para alcançar os atributos do livro
  Livro livro = Livro();

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        var dataAtual = DateTime.now().toLocal();
        var formato = DateFormat('dd-MM-yyyy – HH:mm');
        String datas = formato.format(dataAtual.add(const Duration(hours: 1)));

        //? atualizar a requisição e devolução na base de dados
        _referenciaParaRequisicao = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('isRequisitado');

        //? referencia para registar o utilizador como dono do livro requisitado na base de dados
        _referenciaUID = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('uidLivro');

        //? referencia para registar a data de requisicao na base de dados
        _referenciaDataRequisicao = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('dataRequisicao');

        //? referencia para registar a data de devolucao na base de dados
        _referenciaDataDevolucao = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('dataDevolucao');

        //? o uid do Livro recebe o uid do utilizador na requisição do livro
        livro.uidLivro = utilizador!.uid;

        return Column(
          children: [
            Row(
              children: [
                //* REQUISITAR
                ElevatedButton(
                  ///
                  child:
                      const Text('Requisitar', style: TextStyle(fontSize: 16)),

                  //? Botão fica indisponível depois de fazer a requisição
                  onPressed: widget.livroARequisitar.isRequisitado!
                      ? null
                      : () async {
                          // Fica requisitado

                          setState(() {
                            //? muda o estado de requisição
                            _referenciaParaRequisicao?.set(true);

                            //? regista o id do utilizador que fez a requisição
                            _referenciaUID?.set(livro.uidLivro);

                            //? Data de Requisicao
                            _referenciaDataRequisicao?.set(datas.toString());

                            //? o livro fica requisitado
                            widget.livroARequisitar.isRequisitado = true;

                            //! adicionar o livro na lista de livros requisitados
                            requisitadoModel.addLivroRequisitado(
                              widget.livroARequisitar,
                            );

                            // ignore: avoid_print
                            print('Livro requisitado');
                          });
                        },
                ),

                const SizedBox(width: 35),

                //* DEVOLVER
                ElevatedButton(
                  ///
                  child: const Text('Devolver', style: TextStyle(fontSize: 16)),

                  //? Botão de fazer requisição fica disponível se o utilizador devolver o seu livro requisitado
                  onPressed: widget.livroARequisitar.isRequisitado! &&
                          widget.livroARequisitar.uidLivro!
                              .contains(utilizador!.uid)
                      ? () async {
                          setState(() {
                            //? atulizado o estado de requisição para devolvido
                            _referenciaParaRequisicao?.set(false);

                            //? Data de devolução
                            _referenciaDataDevolucao?.set(datas.toString());

                            //? o livro fica devolvido
                            widget.livroARequisitar.isRequisitado = false;

                            //! adicionar o livro na lista de livros devolvidos
                            requisitadoModel.devolverLivroRequisitado(
                              widget.livroARequisitar,
                            );

                            // ignore: avoid_print
                            print('Livro devolvido');
                          });
                        }
                      : null,
                ),
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

class _BotaoRequisitar extends StatefulWidget {
  final Livro livroARequisitar;

  const _BotaoRequisitar({required this.livroARequisitar, Key? key})
      : super(key: key);

  @override
  State<_BotaoRequisitar> createState() => _BotaoRequisitarState();
}
