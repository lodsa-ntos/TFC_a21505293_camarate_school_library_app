import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/livro.dart';
import 'View_models/home_requisitar_provider.dart';
import 'screens/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => GerarLivro()),

        //**Dependência = GerarLivro --> HomeRequisitarProvider*/
        ChangeNotifierProxyProvider<GerarLivro, HomeRequisitarProvider>(
          create: (context) => HomeRequisitarProvider(),
          update: (context, livro, informacaoDoLivro) {
            if (informacaoDoLivro == null)
              // ignore: curly_braces_in_flow_control_structures
              throw ArgumentError.notNull('Sem informacao do Livro');
            informacaoDoLivro.livro = livro;
            return informacaoDoLivro;
          },
        )
      ],

      //** APLICAÇÃO */
      child: const CamarateSchoolLibraryApp(),
    ),
  );
}

class CamarateSchoolLibraryApp extends StatelessWidget {
  const CamarateSchoolLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // tira o debug do ecrã
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
