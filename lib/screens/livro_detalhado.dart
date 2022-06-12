import 'dart:convert';

import 'package:camarate_school_library/database/base_de_dados.dart';
import 'package:camarate_school_library/models/historico.dart';
import 'package:camarate_school_library/models/livro.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/pessoa.dart';

//? referência para criar os dados do historico na base de dados
DatabaseReference refHistoricoBD = FirebaseDatabase.instance.ref();

//? _Alcançar atributos da classe Historico com referencias do livro requisitado
Historico historico = Historico();

/// Classe para apresentar os widgets que compoêm o formato para representarem
/// os detalhes dos livros
///
//? Alcançar a instância da base de dados para autenticação do utilizador atual
final _auth = FirebaseAuth.instance;

// ignore: must_be_immutable
class LivroDetalhado extends StatelessWidget {
  LivroDetalhado({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<LivroRequisitadoModel>(
        builder: (context, requisitadoModel, child) {
      return Scaffold(
        appBar: AppBar(
          //? Título na barra
          title: const Text('Detalhe'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: FirebaseDatabase.instance.ref("livros").onValue,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      //? Caso não esteja conectado, mostra mensagem
                      case ConnectionState.none:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text("Sem livros para mostrar...")
                          ],
                        );

                      default:
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data.snapshot.value != null) {
                          List<dynamic> dadosBaseDeDados = jsonDecode(
                              jsonEncode(snapshot.data.snapshot.value));

                          LivroModel listaDeLivros =
                              LivroModel.fromJson(dadosBaseDeDados);

                          final List<Livro> _livros = [];

                          _livros.addAll(listaDeLivros.livros);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //** Titulo do livro */
                              Text(
                                _livros[index].titulo.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),

                              const SizedBox(height: 8),
                              //** Autor */
                              Text(
                                _livros[index].autor.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "ISBN: " + _livros[index].isbn.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "Editora: " + _livros[index].editora.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "Requisitado: " +
                                    _livros[index].isRequisitado.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "Nº de Requisições: " +
                                    _livros[index]
                                        .contarVezesRequisitadas
                                        .toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),

                              const SizedBox(height: 16),

                              //** Capa */
                              SizedBox(
                                height: 350,
                                child: Image.network(
                                    _livros[index].imagePath.toString()),
                              ),

                              const SizedBox(height: 12),

                              //*  _Botão Requisitar */
                              _BotaoRequisitar(
                                livroARequisitar: _livros[index],
                              )
                            ],
                          );
                        }
                    }
                    return const Text('sem dados');
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _BotaoRequisitarState extends State<_BotaoRequisitar> {
  DatabaseReference? _referenciaRequisicao;
  DatabaseReference? _referenciaUID;
  DatabaseReference? _referenciaDataRequisicao;
  DatabaseReference? _referenciaDataEntrega;
  DatabaseReference? _referenciaIncrementar;
  DatabaseReference? _referenciaIdHistorico;

  BaseDeDados baseDeDados = BaseDeDados();

  // Utilizador atual
  User? utilizador = _auth.currentUser;

  // Variável do tipo Livro para alcançar os atributos do livro
  Livro livro = Livro();
  Pessoa pessoa = Pessoa();

  //? Obter a chave aleatoria de ids gerados pela base de dados
  String? chave = refHistoricoBD.push().key;

  @override
  Widget build(BuildContext context) {
    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        var dataAtual = DateTime.now().toLocal();
        var formato = DateFormat('dd-MM-yyyy – HH:mm');
        String dataRequisicao = formato.format(dataAtual);

        var formatoDevolucao = DateFormat('dd-MM-yyyy');

        String dataEntrega =
            formatoDevolucao.format(dataAtual.add(const Duration(days: 10)));

        String dataDevolucao = formatoDevolucao.format(dataAtual);

        //? referência para atualizar a requisição e devolução na base de dados
        _referenciaRequisicao = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('isRequisitado');

        //? referência para registar o utilizador como dono do livro requisitado na base de dados
        _referenciaUID = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('uidLivro');

        //? referência para registar a data de requisicao na base de dados
        _referenciaDataRequisicao = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('dataRequisicao');

        //? referência para registar a data de devolucao na base de dados
        _referenciaDataEntrega = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('dataEntrega');

        //? referência para registar a data de devolucao na base de dados
        _referenciaIncrementar = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('contarVezesRequisitadas');

        _referenciaIdHistorico = FirebaseDatabase.instance
            .ref('livros')
            .child(widget.livroARequisitar.id.toString())
            .child('idHistorico');

        //? o uid do Livro recebe o uid do utilizador na requisição do livro
        livro.uidLivro = utilizador!.uid;

        //? Atribuir o valor da chave a variavel id do Historico
        historico.id = chave;

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
                          setState(() {});
                          //? alterar o estado da requisição
                          _referenciaRequisicao?.set(true);

                          //? Regista o id do utilizador que fez a requisição
                          _referenciaUID?.set(livro.uidLivro);

                          //? Contar as vezes que o livro atual foi requisitado
                          _referenciaIncrementar?.set(ServerValue.increment(1));

                          //? Regista a data de Requisicao
                          _referenciaDataRequisicao
                              ?.set(dataRequisicao.toString());

                          //? Regista a data de Entrega
                          _referenciaDataEntrega?.set(dataEntrega.toString());

                          _referenciaIdHistorico?.set(historico.id);

                          //? _Colocar o histórico do livro requisitado pelo utilizador atual na BD
                          criarHistoricoDeRequisicao();

                          //? o livro fica requisitado
                          widget.livroARequisitar.isRequisitado = true;

                          //? adicionar o livro na lista de livros requisitados
                          requisitadoModel.addLivroRequisitado(
                            widget.livroARequisitar,
                          );
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
                            //? atualiza o estado de requisição para devolvido
                            _referenciaRequisicao?.set(false);

                            historico.id = widget.livroARequisitar.idHistorico;

                            //? atualizar a data de devolução para o histórico
                            refHistoricoBD
                                .child('historico')
                                .child(historico.id.toString())
                                .update(
                                    {'dataEntrega': dataDevolucao}).asStream();

                            //? o livro fica devolvido
                            widget.livroARequisitar.isRequisitado = false;

                            //? adicionar o livro na lista de livros devolvidos
                            requisitadoModel.devolverLivroRequisitado(
                              widget.livroARequisitar,
                            );

                            // ignore: avoid_print
                            print('Livro [ ' +
                                widget.livroARequisitar.titulo.toString() +
                                ' ] devolvido');
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

  void criarHistoricoDeRequisicao() async {
    var dataAtual = DateTime.now().toLocal();
    var formato = DateFormat('dd-MM-yyyy – HH:mm');
    String dataRequisicao = formato.format(dataAtual);

    //? referência para alcançar os dados do utilizador na base de dados
    DatabaseReference _referenciaUtilizadorBD =
        FirebaseDatabase.instance.ref('utilizadores').child(utilizador!.uid);

    //? Obter os dados guardados pelo utilizador
    Map<String, dynamic> dadosUtilizador =
        await baseDeDados.getUtilizadoresBD(_referenciaUtilizadorBD);

    historico.requisitante =
        Pessoa.fromJson(dadosUtilizador).nomeCompletoPessoa;

    historico.tituloLivro = widget.livroARequisitar.titulo;

    historico.dataRequisicao = dataRequisicao.toString();

    historico.uidRequisitante = livro.uidLivro;

    historico.idLivro = widget.livroARequisitar.id;

    historico.dataEntrega = widget.livroARequisitar.dataDevolucao;

    //? Enviar os dados de requisição para a referencia do historico para a base de dados
    await refHistoricoBD
        .child('historico')
        .child(historico.id.toString())
        .set(historico.toJson());

    // ignore: avoid_print
    print('O livro [ ' +
        widget.livroARequisitar.titulo.toString() +
        ' ] foi requisitado pelo utilizador ' +
        Pessoa.fromJson(dadosUtilizador).nomeCompletoPessoa.toString());
  }
}

class _BotaoRequisitar extends StatefulWidget {
  final Livro livroARequisitar;

  const _BotaoRequisitar({required this.livroARequisitar, Key? key})
      : super(key: key);

  @override
  State<_BotaoRequisitar> createState() => _BotaoRequisitarState();
}
