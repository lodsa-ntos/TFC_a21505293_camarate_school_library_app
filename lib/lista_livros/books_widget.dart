import 'package:flutter/material.dart';
import 'inventory.dart';

class BooksWidget extends StatelessWidget {
  final RegisterBooks books;

  const BooksWidget({Key? key, required this.books})
      // ignore: unnecessary_null_comparison
      : assert(books != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aqui defino a minha lista a ser apresentada no inicio
    //antes de se pesquisar alguma coisa....
    return Card(
      child: ListTile(
        onTap: () {
          // ignore: avoid_print
          print("${books.titulo} pressed");
        },
        leading: Image.network(books.imagem),
        title: Text(books.titulo),
        subtitle: Text(books.autor),
      ),
      elevation: 12,
    );
  }
}
