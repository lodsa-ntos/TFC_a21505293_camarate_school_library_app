import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Interface/screens/home.dart';
import 'Models/livro.dart';
import 'View_models/repositorio_livros_requisitados.dart';

void main() => runApp(const CamarateSchoolLibraryApp());

class CamarateSchoolLibraryApp extends StatelessWidget {
  const CamarateSchoolLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usar MultiProvider para fornecer vários objetos de uma lista
    return MultiProvider(
      // Simples Provider é o suficiente para uma lista que não terá mudanças
      providers: [
        // GerarLivro = Livros Prateleiras
        Provider(create: (context) => GerarLivro()),

        // Depende do provider acima ... Funciona, mas porquê?
        // Na primeira caixa(GerarLivro), quero tirar um livro (requisicao),
        // e colocar esse livro numa outra caixa (RepositorioLivrosRequisitados)
        // O provider dá o valor e o consumer consome esse valor
        ChangeNotifierProvider(
          create: (context) => RepositorioLivrosRequisitados(),
        ),
      ],
      child: MaterialApp(
        // Por enquanto, o home será o ecrã inicial da app
        initialRoute: '/home',
        // tira o debug do ecrã
        debugShowCheckedModeBanner: false,
        routes: {'/home': (context) => const Home()},
      ),
    );
  }
}
