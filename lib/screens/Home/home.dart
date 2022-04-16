import 'package:camarate_school_library/Database/base_de_dados.dart';
import 'package:camarate_school_library/screens/detalhe/livro_detalhado.dart';
import 'package:camarate_school_library/screens/pesquisa/pesquisar.dart';
import 'package:camarate_school_library/view_models/auth_view_model.dart';
import 'package:camarate_school_library/view_models/livro_requisitado_view_model.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//** VARIÁVEIS GLOBAIS */
final getLivrosBD = BaseDeDados();

//* Espaçamento
const espacamento = SizedBox(
  height: 14,
);

//* TÍtulo [Prateleiras]
const prateleiras = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Prateleiras',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

//* TÍtulo [Livros Requisitados]
const livrosRequisitados = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Livros Requisitados',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

//* PÁGINA HOME
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var mostrarLivro = Consumer<LivroRequisitadoModel>(
      builder: (BuildContext context, LivroRequisitadoModel detalheModel,
          Widget? child) {
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
                        //* Aqui o utilizador consegue carregar em cima do livro
                        //* e ser direcionado para o ecrã de livro detalhado
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
                                margin: const EdgeInsets.only(right: 12.0),
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
                                    Text(
                                      snapshot.data[index].isRequisitado
                                          .toString(),
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
          },
        );
      },
    );

    return Consumer<LivroRequisitadoModel>(
      builder: (BuildContext context, LivroRequisitadoModel detalheModel,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Livros'), // Título

            actions: <Widget>[
              //** Icone de pesquisa */
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
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
              // Importante: Remove qualquer preenchimento a mais do ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: null,
                ),
                ListTile(
                  title: const Text(
                      'Terminar sessão'), // Titulo dentro do menu lateral

                  /// Aceder ao metodo com o provider para terminar sessão
                  onTap: () => context.read<AuthModel>().terminarSessao(),
                ),
              ],
            ),
          ),

          //* Este SingleChildScrollView será geral para toda a página home e fará apenas
          //* scroll na vertical

          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
