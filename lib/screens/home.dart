import 'dart:convert';

import 'package:camarate_school_library/models/categoria.dart';
import 'package:camarate_school_library/models/livro.dart';
import 'package:camarate_school_library/screens/obras_requisitadas.dart';
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
import 'package:intl/intl.dart';

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //

    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
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
            title: const Text('Home'),
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
                ListTile(
                    title: const Text('Obras requisitadas'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //** Redireciona o utilizador para a página de detalhes do livro */
                          builder: (context) => const ObrasRequisitadas(),
                        ),
                      );
                    }),
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
                      setState(() {});
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

          //? CONSTRUIR INTERFACE PARA O UTILIZADOR

          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //* APRESENTAR LIVROS REQUISITADOS - INTERFACE PARA O UTILIZADOR

                //_livrosRequisitados,

                //? Título
                prateleiras,

                //* APRESENTAR LIVROS DAS PRATELEIRAS - INTERFACE PARA O UTILIZADOR
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: 375.0,
                    child: _livrosDasPrateleiras,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Flexible(
                        child: Text(
                          'Generalidades',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
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

//* Função da mensagem para alertar o utilizador
void alertarUtilizador(BuildContext context) {
  showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Prazo de entrega"),
        content: const Text(
          "Tem de fazer a entrega do livro até a data indica, obrigado!",
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

//** VARIÁVEIS GLOBAIS */

//? StreamBuilder para carregar da base de dados os livros das prateleiras
final _livrosDasPrateleiras = Consumer<LivroRequisitadoModel>(
  builder: (context, requisitadoModel, child) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref("livros").onValue, // async work
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
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                List<dynamic> dadosBaseDeDados =
                    jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                LivroModel listaDeLivros =
                    LivroModel.fromJson(dadosBaseDeDados);

                List<Livro> _livrosPrateleira = [];

                _livrosPrateleira.addAll(listaDeLivros.livros);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _livrosPrateleira.length,
                  itemBuilder: (BuildContext context, int index) {
                    //
                    //? variável para representar o estado de requisição
                    String _estadoDeRequisicao =
                        _livrosPrateleira[index].isRequisitado.toString();

                    const Text(
                      'Generalidades',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );

                    if (_livrosPrateleira[index].numColecao == '0') {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //** Redireciona o utilizador para a página de detalhes do livro */
                              builder: (context) => LivroDetalhado(
                                index: index,
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
                                            _livrosPrateleira[index]
                                                .imagePath
                                                .toString(),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 12.0),

                                    //** Titulo */
                                    Text(
                                        _livrosPrateleira[index]
                                            .titulo
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        )),

                                    const SizedBox(height: 5.0),

                                    //** Autor */
                                    Text(_livrosPrateleira[index]
                                        .autor
                                        .toString()),

                                    const SizedBox(height: 5.0),

                                    //** isRequisitado */
                                    Text(
                                      _estadoDeRequisicao.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    switch (_livrosPrateleira[index].numColecao) {
                      case "0":
                        const Text(
                          'Generalidades',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //** Redireciona o utilizador para a página de detalhes do livro */
                                builder: (context) => LivroDetalhado(
                                  index: index,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              _livrosPrateleira[index]
                                                  .imagePath
                                                  .toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 12.0),

                                      //** Titulo */
                                      Text(
                                          _livrosPrateleira[index]
                                              .titulo
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          )),

                                      const SizedBox(height: 5.0),

                                      //** Autor */
                                      Text(_livrosPrateleira[index]
                                          .autor
                                          .toString()),

                                      const SizedBox(height: 5.0),

                                      //** isRequisitado */
                                      Text(
                                        _estadoDeRequisicao.toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      default:
                        return Text('');
                    }

                    //
                  },
                );
              }
            }
            return const Text("Sem dados...");
        }
      },
    );
  },
);

final _livrosRequisitados = Consumer<LivroRequisitadoModel>(
    builder: (context, requisitadoModel, child) {
  return Column(
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text(" A carregar livros requisitados...")
                  ],
                );

              case ConnectionState.none:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[Text("Sem livros para mostrar...")],
                );

              default:
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data.snapshot.value != null) {
                  // Alcançar a instância da base de dados para autenticação do utilizador atual
                  final _auth = FirebaseAuth.instance;

                  // Utilizador actual
                  User? utilizador = _auth.currentUser;

                  var data = DateTime.now().toLocal();
                  var formato = DateFormat('dd-MM-yyyy');

                  String dataAtual = formato.format(data.toLocal());
                  String dataUmDiaAntes =
                      formato.format(data.subtract(const Duration(days: 1)));
                  String dataSemEntregar =
                      formato.format(data.add(const Duration(days: 1)));

                  //? tRanformar os dados da base de dados numa lista dinamica
                  List<dynamic> dadosBaseDeDados =
                      jsonDecode(jsonEncode(snapshot.data.snapshot.value));

                  //? Adaptar ao modelo de livro
                  LivroModel listaDeLivros =
                      LivroModel.fromJson(dadosBaseDeDados);

                  //? Lista para guardar os dados convertidos e decodificados
                  final List<Livro> _livros = [];

                  _livros.addAll(listaDeLivros.livros);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    height: 290.0,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _livros.length,
                            itemBuilder: (context, index) {
                              //* Construir livro requisitado na interface
                              if (_livros[index].uidLivro == utilizador!.uid &&
                                  _livros[index].isRequisitado == true) {
                                return InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //? Redireciona o utilizador para a página de detalhes do livro */
                                      builder: (context) => LivroDetalhado(
                                        index: index,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 103.0,
                                        margin:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120.66,
                                              height: 155.5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    _livros[index]
                                                        .imagePath
                                                        .toString(),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                            Text(
                                              _livros[index].titulo.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            if (_livros[index].dataEntrega ==
                                                    dataAtual ||
                                                _livros[index].dataEntrega ==
                                                    dataUmDiaAntes ||
                                                _livros[index].dataEntrega ==
                                                    dataSemEntregar) ...[
                                              Text(
                                                'Data de devolução: ' +
                                                    _livros[index]
                                                        .dataEntrega
                                                        .toString(),
                                                style: GoogleFonts.catamaran(
                                                  textStyle: const TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ] else ...[
                                              Text(
                                                'Data de entrega: ' +
                                                    _livros[index]
                                                        .dataEntrega
                                                        .toString(),
                                                style: GoogleFonts.catamaran(
                                                  textStyle: const TextStyle(
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text("Sem dados");
                }
            }
          },
        ),
      ),
    ],
  );
});

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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
