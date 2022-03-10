import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Interface/screens/home.dart';
import 'Models/livro.dart';
import 'View_models/repositorio_livros_requisitados.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // GerarLivro = Livros Prateleiras
        Provider(create: (_) => GerarLivro()),

        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const CamarateSchoolLibraryApp(),
    ),
  );
}

class CamarateSchoolLibraryApp extends StatelessWidget {
  const CamarateSchoolLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usar MultiProvider para fornecer vários objetos de uma lista
    return MaterialApp(
      // Por enquanto, o home será o ecrã inicial da app
      initialRoute: '/home',
      // tira o debug do ecrã
      debugShowCheckedModeBanner: false,
      routes: {'/home': (context) => const Home()},
    );
  }
}
