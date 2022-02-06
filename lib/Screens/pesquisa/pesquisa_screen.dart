import 'dart:convert';

import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Utils/cores.dart';
import 'package:camarate_school_library/Utils/estilo_texto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: use_key_in_widget_constructors
class Pesquisa extends StatefulWidget {
  @override
  _PesquisaState createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
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
    final livrosJSON = await rootBundle.loadString("assets/files/livros.json");
    var dadosDecodificados = jsonDecode(livrosJSON);
    var informacoesDoLivro = dadosDecodificados["livros"];

    Livros.livros = List.from(informacoesDoLivro)
        .map<Livro>((livros) => Livro.fromMap(livros))
        .toList();
    setState(() {});
  }

  // Widget de construção da página, conteúdo visual.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.grey.shade100,
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

          // Campo para fazer a pesquisa do livro
          CupertinoSearchTextField(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            itemSize: 25,
            prefixInsets: const EdgeInsets.only(left: 12),
            suffixInsets: const EdgeInsets.only(right: 12),
            autofocus: true,
            placeholder: "Pesquise o seu livro...",
            onChanged: (value) {},
          ).p12(),

          // --> Botões das categorias
          Container(
            margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
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
                      left: kDefaultPadding, // tamanho do espaçamento
                      right:
                          index == categorias.length - 1 ? kDefaultPadding : 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: index == selecionarCategorias
                        ? Colors.blue.withOpacity(0.4)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.black26,
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

          Expanded(
            // ignore: unnecessary_null_comparison
            child: Container(
              padding: Vx.m16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Se o inventario dos livros forem diferentes de null (sem valor)
                  //e os campos não estiverem vazios vamos expandir a lista,
                  //senão mostra o icon do loading a carregar a pensar....
                  // ignore: unnecessary_null_comparison
                  if (Livros.livros != null && Livros.livros.isNotEmpty) ...[
                    const ListaDeInventario().expand()
                  ] else
                    // reload icon
                    const CircularProgressIndicator()
                        .centered()
                        .py16()
                        .expand(),
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
        itemCount: Livros.livros.length,
        itemBuilder: (context, index) {
          final inventario = Livros.livros[index];
          return LivrosNoInventario(inventario: inventario);
        });
  }
}

// Classe para definir as imagens dos livros
// ignore: must_be_immutable
class LivrosNoInventario extends StatelessWidget {
  Livro inventario;

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
          Image.network(inventario.imagemCapa)
              .box
              .rounded // borda a volta da imagem
              .p8 // tamanho da imagem
              .color(Colors.black12) // cor da caixa
              .make()
              .p16()
              .w32(context),

          // o que quero mostrar na lista de livros
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

                // espaçamento
                const SizedBox(
                  height: 5,
                ),

                // Nome do autor
                inventario.autor.text
                    .color(MyThemeColor.myGreyStyleColor)
                    .make(),

                // Espaçamento
                10.heightBox,

                // area da disponibilidade do livro e botão requisitar
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  buttonPadding: EdgeInsets.zero,
                  children: [
                    // Disponibilidade do livro
                    if (inventario.disponibilidade == 'Disponível') ...[
                      inventario.disponibilidade.text.xl
                          .color(Colors.green)
                          .make(),
                    ] else
                      inventario.disponibilidade.text.xl
                          .color(Colors.grey.shade600)
                          .bold
                          .make(),

                    // Botão requisitar
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade600),
                          shape: MaterialStateProperty.all(
                            const StadiumBorder(),
                          )),
                      child: 'Requisitar'.text.make(),
                    ),
                  ],
                ).pOnly(
                    right:
                        8.0), // afasta o botão requisitar da margen a direita
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
        .py12(); // espaçamento entre linhas
  }
}
