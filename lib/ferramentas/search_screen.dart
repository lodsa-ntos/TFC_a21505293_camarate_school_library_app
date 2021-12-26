import 'dart:convert';

import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:camarate_school_library/guia_de_estilo/text_styles.dart';
import 'package:camarate_school_library/lista_livros/inventory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: use_key_in_widget_constructors
class PesquisaScreen extends StatefulWidget {
  @override
  _PesquisaScreenState createState() => _PesquisaScreenState();
}

class _PesquisaScreenState extends State<PesquisaScreen> {
  List categorias = ['Todos', 'Autor', 'Título', 'Ano']; // Lista de categorias
  int selecionarCategorias = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  // sempre que abrir o ecrã de pesquisa carrega a minha lista inicial de livros
  //do ficheiro .json...
  carregarDados() async {
    final livrosJSON =
        await rootBundle.loadString("assets/files/inventario_livros.json");
    var dadosDecodificados = jsonDecode(livrosJSON);
    var informacoesDoLivro = dadosDecodificados["livros"];

    Inventario.books = List.from(informacoesDoLivro)
        .map<RegisterBooks>((books) => RegisterBooks.fromMap(books))
        .toList();
    setState(() {});
  }

  // Widget de construção da página, conteúdo visual.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Pesquisar",
              style: headingTextStyle.copyWith(color: Colors.black),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Pesquise o seu livro...",
                ),
              ),
            ),
          ),

          // --> Botões para as categorias
          Container(
            margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            height: 35, // tamanho dos botões
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categorias.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selecionarCategorias = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: kDefaultPadding,
                      right:
                          index == categorias.length - 1 ? kDefaultPadding : 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: index == selecionarCategorias
                        ? Colors.blue.withOpacity(0.4)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Text(
                    categorias[index],
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ),
          ),
          // fim de botões para as categorias...

          // Se o inventario dos livros forem diferentes de null (sem valor)
          //e os campos não estiverem vazios vamos expandir a lista,
          //senão mostra o icon do loading a carregar a pensar....
          Expanded(
            // ignore: unnecessary_null_comparison
            child: Container(
              padding: Vx.m16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: unnecessary_null_comparison
                  if (Inventario.books != null && Inventario.books.isNotEmpty)
                    const ListaDeInventario().expand()
                  else
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --> Classe para montar a lista para os livros carregados no ficheiro JSON
class ListaDeInventario extends StatelessWidget {
  const ListaDeInventario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: Inventario.books.length,
        itemBuilder: (context, index) {
          final inventario = Inventario.books[index];
          return LivrosNoInventario(inventario: inventario);
        });
  }
}

// Classe para definir as imagens dos livros
// ignore: must_be_immutable
class LivrosNoInventario extends StatelessWidget {
  RegisterBooks inventario;

  LivrosNoInventario({
    Key? key,
    required this.inventario,
    // ignore: unnecessary_null_comparison
  })  : assert(inventario != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Image.network(inventario.imagem)
              .box
              .rounded // borda a volta da imagem
              .p8 // tamanho da imagem
              .color(Colors.black12) // cor da caixa
              .make()
              .p16()
              .w32(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título do Livro
                inventario.titulo.text.xl.lg
                    .color(MyThemeColor.darkBluishColor)
                    .bold
                    .make(),

                // Nome do autor
                inventario.autor.text
                    .color(MyThemeColor.myGreyStyleColor)
                    .make(),

                // espaçamento
                const SizedBox(
                  height: 12,
                ),

                // Tentar uma outra maneira de implementar
                const Text(
                  'Disponível',
                  style:
                      TextStyle(color: Colors.green, fontFamily: 'Montserrat'),
                ),

                // espaçamento
                const SizedBox(
                  height: 5,
                ),

                // botao requisitar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onSurface: Colors.green,
                    elevation: 5,
                    shadowColor: Colors.grey,
                  ),
                  child: const Text('Requisitar'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .white // fundo com cor branca nos retangulos
        .rounded // curva nas bordas dos retangulos
        .square(150) // tamanho das imagens dos livros
        .make()
        .py16(); // espaçamento entre linhas
  }
}
