import 'dart:convert';

import 'package:camarate_school_library/Database/base_de_dados.dart';
import 'package:camarate_school_library/models/livro_model.dart';
import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:camarate_school_library/screens/login.dart';
import 'package:camarate_school_library/screens/livro_detalhado.dart';
import 'package:camarate_school_library/screens/notificacao.dart';
import 'package:camarate_school_library/screens/pesquisar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//** VARIÁVEIS GLOBAIS */

// espaçamento
const espacamento = SizedBox(
  height: 14,
);

// tÍtulo [Prateleiras]
const prateleiras = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Prateleiras',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

// tÍtulo [Livros Requisitados]
const livrosRequisitados = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Livros Requisitados',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

// PÁGINA HOME
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<LivroModel> livrosRequisitadosBD = [];
  Livro? livroModel;

  @override
  Widget build(BuildContext context) {
    /// variável o carregamento da informação dos livros a serem apresentados
    /// na interface
    var mostrarLivro = Consumer<LivroRequisitadoModel>(
      builder: (context, detalheModel, child) {
        // Um pequeno tema para o texto(titulo, subTitulo, etc)
        var textTheme = Theme.of(context).textTheme.headline6;

        final referenciaBD = FirebaseDatabase.instance.ref().child('livros');
        final fazerLigacao = BaseDeDados();

        return FutureBuilder(
          future: fazerLigacao.carregarLivrosBD(referenciaBD), // async work
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text(" A carregar livros...")
                  ],
                );
              case ConnectionState.none:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[Text("Sem livros para mostrar...")],
                );
              default:
                if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      //
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //** Redireciona o utilizador para a página de detalhes do livro */
                              builder: (context) => LivroDetalhado(
                                livro: snapshot.data[index],
                              ),
                            ),
                          );
                        },

                        //** Widgets que vão desenvolver formato dos livros a serem apresentados
                        //** no página home */
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 122.0,
                                margin: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 121.66,
                                      height: 190.5,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          //** Capa */
                                          image: NetworkImage(
                                            snapshot.data[index].imagePath,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 12.0),

                                    //** Titulo */
                                    Text(snapshot.data[index].titulo,
                                        style: textTheme),

                                    const SizedBox(height: 5.0),

                                    //** Autor */
                                    Text(snapshot.data[index].autor),

                                    const SizedBox(height: 5.0),

                                    //** isRequisitado */
                                    Text(snapshot.data[index].isRequisitado
                                        .toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
            }
          },
        );
      },
    );

    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        final referenciaBD = FirebaseDatabase.instance.ref().child('livros');
        final fazerLigacao = BaseDeDados();

        //! Alcançar a instancia da abse de dados para autenticação do utilizador atual
        final _auth = FirebaseAuth.instance;
        // Utilizador atual que preencheu o formulário
        User? utilizador = _auth.currentUser;

        // Variável do tipo aluno para alcançar os atributos do aluno
        Livro teste = Livro();

        teste.uidLivro = utilizador!.uid;

        return Scaffold(
          appBar: AppBar(
            // icone de pesquisa
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //** Redireciona o utilizador para a página de detalhes do livro */
                      builder: (context) => const PesquisaDeLivro(),
                    ),
                  );
                },
              ),
            ],
          ),

          /// Menu Lateral
          drawer: Drawer(
            child: ListView(
              // eemove qualquer preenchimento a mais do ListView.
              padding: EdgeInsets.zero,

              /// menu lateral e campos
              children: [
                const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue), child: null),
                ListTile(title: const Text('Ajuda'), onTap: () {}),
                ListTile(title: const Text('Estatística'), onTap: () {}),
                ListTile(
                  title: const Text('Notificação'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        //** Redireciona o utilizador para a página de notificacao*/
                        builder: (context) => const Notificacao()),
                  ),
                ),
                const SizedBox(height: 215.0),
                ListTile(
                    title: const Text(
                      'Terminar sessão',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ), // Título dentro do menu lateral

                    /// Aceder ao metodo com o provider para terminar sessão
                    onTap: () async {
                      await context.read<AuthServices>().terminarSessao();
                      await Navigator.pushAndRemoveUntil(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    }),
              ],
            ),
          ),

          //? INTERFACE PARA O UTILIZADOR
          //* LIVROS REQUISITADOS + LIVROS PRATELEIRAS

          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                livrosRequisitados,
                Container(
                  margin: const EdgeInsets.only(left: 3.0, right: 5.0),
                  child: StreamBuilder(
                    stream: FirebaseDatabase.instance.ref("livros").onValue,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasData &&
                              !snapshot.hasError &&
                              snapshot.data.snapshot.value != null) {
                            List<dynamic> dadosBaseDeDados = jsonDecode(
                                jsonEncode(snapshot.data.snapshot.value));

                            LivroModel listaDeLivros =
                                LivroModel.fromJson(dadosBaseDeDados);

                            List<Livro> _livros = [];

                            _livros.addAll(listaDeLivros.livros);

                            print(listaDeLivros.livros.length);

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              height: 290.0,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: dadosBaseDeDados.length,
                                      itemBuilder: (context, index) {
                                        if (_livros[index].uidLivro ==
                                                utilizador.uid &&
                                            _livros[index].isRequisitado ==
                                                true) {
                                          return InkWell(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                //** Redireciona o utilizador para a página de detalhes do livro */
                                                builder: (context) =>
                                                    LivroDetalhado(
                                                  livro: _livros[index],
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 103.0,
                                                  margin: const EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 120.66,
                                                        height: 155.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                _livros[index]
                                                                    .imagePath
                                                                    .toString()),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12.0,
                                                      ),
                                                      Text(
                                                        _livros[index]
                                                            .titulo
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        'Data de requisição: ' +
                                                            _livros[index]
                                                                .dataRequisicao
                                                                .toString(),
                                                        style: GoogleFonts
                                                            .catamaran(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 13.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        return const Text('sem dados');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else
                            return Text("No data");
                      }
                    },
                  ),
                ),

                //? Título
                prateleiras,

                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: 375.0,
                    child: mostrarLivro,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
