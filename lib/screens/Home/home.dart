import 'package:camarate_school_library/Database/base_de_dados.dart';
import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:camarate_school_library/screens/auth/login.dart';
import 'package:camarate_school_library/screens/detalhe/livro_detalhado.dart';
import 'package:camarate_school_library/screens/notificacao/notificacao.dart';
import 'package:camarate_school_library/screens/pesquisa/pesquisar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; // DateFormat

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
                return const Center(child: CircularProgressIndicator());
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

    /// variavel para obter a informacao Map<String, LivroModel> sobre o livro
    /// requisitado
    final listaLivro = Provider.of<LivroRequisitadoModel>(context);

    return Consumer<LivroRequisitadoModel>(
      builder: (context, requisitadoModel, child) {
        final referenciaBD = FirebaseDatabase.instance.ref().child('livros');
        final fazerLigacao = BaseDeDados();
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

          /// este SingleChildScrollView será geral para toda a página home
          /// e fará apenas scroll na vertical

          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (listaLivro.livros.isNotEmpty) ...[
                  //* Título
                  livrosRequisitados,

                  //** Este SingleChildScrollView vai fazer scroll na horizontal
                  //** vai apresentar os livros que foram requisitados */
                  SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      height: 276.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FormatoLivroRequisitadoParaUtilizador(),
                        ],
                      ),
                    ),
                  ),
                ],

                //* Título
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

class _FormatoLivroRequisitadoParaUtilizador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Aqui obtenho a data do dia atual
    // E guardo o formato de como quero que a data apareça para o utilizador
    var dataDeHoje = DateTime.now();
    var formato = DateFormat('dd-MM-yyyy');
    String data = formato.format(dataDeHoje);

    return Consumer<LivroRequisitadoModel>(
      builder: (BuildContext context, LivroRequisitadoModel requisitadoModel,
          Widget? child) {
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: requisitadoModel.livros.length,
            itemBuilder: (context, index) {
              final livro = requisitadoModel.livros.values.toList()[index];

              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    //** Redireciona o utilizador para a página de detalhes do livro */
                    builder: (context) => LivroDetalhado(
                      livro: livro,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 111.0,
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 121.66,
                            height: 165.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(livro.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            livro.titulo,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Data de requisição: ' + data,
                            style: GoogleFonts.catamaran(
                              textStyle: const TextStyle(
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
            },
          ),
        );
      },
    );
  }
}
