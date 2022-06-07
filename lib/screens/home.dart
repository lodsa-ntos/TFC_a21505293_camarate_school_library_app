import 'package:camarate_school_library/screens/historico_de_requisicao.dart';
import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:camarate_school_library/screens/login.dart';
import 'package:camarate_school_library/screens/pesquisar.dart';
import 'package:camarate_school_library/util/mostrar_seccoes_livros.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                ListTile(
                    title: const Text('Histórico'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //** Redireciona o utilizador para a página de detalhes do livro */
                          builder: (context) => const HistoricoDeRequisicao(),
                        ),
                      );
                    }),
                ListTile(title: const Text('Ajuda'), onTap: () {}),
                ListTile(title: const Text('Sobre nós'), onTap: () {}),
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

                Mostrar().livrosRequisitados,

                //? Título [Prateleiras] na interface
                prateleiras,

                espacamento,

                _categoria("Generalidades. Dicionários"),

                espacamento,

                //? CATEGORIA LIVROS GENERALIDADES
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: 333.0,
                    child: Mostrar().livrosSeccaoAmarela,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //? Separar as categorias
  _categoria(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                children: [
                  //_livroPrateleira,
                  if (titulo == "Generalidades. Dicionários") ...[
                    const CircleAvatar(
                      backgroundColor: Colors.yellow,
                      minRadius: 15,
                    ),
                  ] else if (titulo == "Filosofia e Psicologia") ...[
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 231, 205, 166),
                      minRadius: 15,
                    ),
                  ] else if (titulo == "Religião e Teologia") ...[
                    const CircleAvatar(
                      backgroundColor: Colors.orange,
                      minRadius: 15,
                    ),
                  ] else if (titulo == "Ciências Sociais") ...[
                    const CircleAvatar(
                      backgroundColor: Colors.brown,
                      minRadius: 15,
                    ),
                  ],

                  Padding(
                    // espaço entre o circulo e o título da classe
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*
          InkWell(
            onTap: () {},
            child: const Text(
              'ver todos',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          */
        ],
      ),
    );
  }
}

//** VARIÁVEIS GLOBAIS */

// espaçamento
const espacamento = SizedBox(
  height: 15,
);

// tÍtulo [Prateleiras]
const prateleiras = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Prateleiras',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
