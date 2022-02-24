import 'package:camarate_school_library/Models/modelo_informacao_livro.dart';
import 'package:camarate_school_library/Screens/historico.dart';
import 'package:camarate_school_library/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Common/temaAppBar.dart';
import 'Models/modelo_do_livro.dart';

void main() {
  runApp(const CamarateSchoolLibraryApp());
}

class CamarateSchoolLibraryApp extends StatelessWidget {
  const CamarateSchoolLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usar MultiProvider para fornecer vários objetos de uma lista
    return MultiProvider(
      // Simples Provider é o suficiente para uma lista que não terá mudanças
      providers: [
        Provider(create: (context) => ModeloDoLivro()),
        // ModeloDeInformacaoLivro() é implementado como um ChangeNotifier num outro ficheiro a parte,
        // que vai depois chamar o ChangeNotifierProvider que está aqui abaixo. Além disso, o ControlarInformacaoLivro()
        // vai depender do ModeloDeLivro, portanto, é necessário um ProxyProvider.
        ChangeNotifierProxyProvider<ModeloDoLivro, ModeloInformacaoLivro>(
          create: (context) => ModeloInformacaoLivro(),
          update: (context, livro, informacaoDoLivro) {
            if (informacaoDoLivro == null)
              // ignore: curly_braces_in_flow_control_structures
              throw ArgumentError.notNull('Sem informacao do Livro');
            informacaoDoLivro.livro = livro;
            return informacaoDoLivro;
          },
        )
      ],
      child: MaterialApp(
        theme: temaDoApp,
        initialRoute:
            '/home', // Por enquanto, o home será o ecrã inicial da app
        // tira o debug do ecrã
        debugShowCheckedModeBanner: false,
        routes: {
          //'/': (context) => const MyLogin(), --> por enquanto não será preciso login
          '/home': (context) => const HomeScreen(),
          '/historico': (context) => const Historico(),
        },
      ),
    );
  }
}
