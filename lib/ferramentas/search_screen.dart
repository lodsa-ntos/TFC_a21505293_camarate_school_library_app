import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camarate_school_library/guia_de_estilo/color_styles.dart';
import 'package:camarate_school_library/guia_de_estilo/text_styles.dart';

// ignore: use_key_in_widget_constructors
class PesquisaScreen extends StatefulWidget {
  @override
  _PesquisaScreenState createState() => _PesquisaScreenState();
}

class _PesquisaScreenState extends State<PesquisaScreen> {
  // Widget de construção da página, conteúdo visual.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.white,
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

          // Categorias
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Text(
                  "categorias aqui",
                  style: subTitleStyle.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  width: 25,
                  height: 25,
                  child: Center(
                    child: Text(
                      "5",
                      style: whiteSubHeadingTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          // fim de categorias...

          // Lista de livros
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ListTile(
                    title: const Text(
                      "Livros",
                      style: titleStyle,
                    ),
                    trailing: SizedBox(
                      width: 75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Row(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },

              // Numero de linhas
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
