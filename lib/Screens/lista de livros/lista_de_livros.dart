import 'package:camarate_school_library/Models/livro.dart';
import 'package:camarate_school_library/Screens/Detalhe%20do%20livro/livro_detalhado.dart';
import 'package:flutter/material.dart';

class ListaDeLivros extends StatelessWidget {
  const ListaDeLivros({Key? key, required this.livros}) : super(key: key);

  final List<Livro> livros;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros'),
      ),
      body: ListView.builder(
        itemCount: livros.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Text("\"" + livros[index].titulo + "\""),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  child: Text(
                    "de: " + livros[index].autor,
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LivroDetalhado(livro: livros[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
