import 'package:camarate_school_library/Models/modelo_informacao_livro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // DateFormat

import 'lista_de_livros.dart';

// Espaçamento para algumas áreas
const espacamento = SizedBox(
  height: 14,
);

// Apenas o titulo --> Prateleiras no ecrã
const prateleiras = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Prateleiras',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

// Apenas o titulo --> Livros Requisitados no ecrã
const livrosRequisitados = Padding(
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Livros Requisitados',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);

//
//

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // Um pequeno tema para o texto(titulo, subTitulo, etc)
    var textTheme = Theme.of(context).textTheme.headline6;

    /// Página Home
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros'), // Título
        actions: <Widget>[
          /// Icone de pesquisa
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),

      /// Menu Lateral
      drawer: Drawer(
        child: ListView(
          // Importante: Remove qualquer preenchimento a mais do ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Lateral',
                style: textTheme,
              ),
            ),
            ListTile(
              title: Text(
                'Histórico',
                style: textTheme,
              ), // Titulo dentro do menu lateral
              onTap: () => Navigator.pushNamed(context, '/historico'),
            ),
          ],
        ),
      ),

      /// Este SingleChildScrollView será geral para toda a página home e fará apenas
      /// scroll na vertical
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // Título
            livrosRequisitados,
            //
            // Este SingleChildScrollView na horizontal apresenta a Área dos
            //livros que foram requisitados
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 310.0,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        // apresenta o livro requisitado no ecrã
                        child: _FormatoLivroRequisitadoParaUtilizador(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Espaçmento vertical
            espacamento,

            // Título
            prateleiras,
            //
            // Este SingleChildScrollView faz scroll apenas na horizontal
            //e irá apresentar a Área dos livros das prateleiras
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 375.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // comportamento para que a ListView só ocupe o espaço que precisa
                    shrinkWrap: true,
                    // ERRO DO BAD STATE: NO ELEMENT --> Resolver
                    itemBuilder: (context, index) =>
                        ListaDeLivros(index: index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Esta classe está aqui apenas para espelhar o que aparece no ecrã do histórico
//
/// Esta classe representa o formato de como quero que os livros requisitados
/// apareçam no ecrã para o utilizador
class _FormatoLivroRequisitadoParaUtilizador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Isto (context.watch<ModeloInformacaoLivro>();) obtém o estado atual do ModeloInformacaoLivro e também informa ao Flutter
    // para reconstruir este widget quando o ModeloInformacaoLivro notificar
    // aos utilizadores (em outras palavras, quando muda).
    var requisicao = context.watch<ModeloInformacaoLivro>();

    // Aqui obtenho a data do dia atual
    // E guardo o formato de como quero que a data apareça para o utilizador
    var dataDeHoje = DateTime.now();
    var formato = DateFormat('dd-MM-yyyy');
    String data = formato.format(dataDeHoje);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: requisicao.livros.length,
      itemBuilder: (context, index) => Row(
        children: [
          Container(
            width: 111.0,
            margin: const EdgeInsets.only(right: 12.0),
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
                      image: NetworkImage(requisicao.livros[index].imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  requisicao.livros[index].titulo,
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
                  'Data de Entrega: ' + data,
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
  }
}
