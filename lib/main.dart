import 'package:camarate_school_library/Screens/Home/home.dart';
import 'package:camarate_school_library/Screens/login.dart';
import 'package:camarate_school_library/Models/Auth/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/Livro/livro_requisitado_model.dart';
import 'Database/repositorio_de_livros.dart';

Future<void> main() async {
  /// Necessário para usar canais para chamar o código nativo
  /// para inicializar o Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        //** Exponho o primeiro valor da minha lista na página home (Livros da prateleira) */
        Provider(create: (_) => RepositorioDeLivros()),

        //** Dependência = GerarLivro --> HomeRequisitarProvider
        //** Ao carregar no botao requisitar, consumo o primeiro valor livro da
        //** lista na classe GerarLivro e guardo na funcao da classe LivrosRequisitadosModel
        //** que é o addLivrosRequisitados*/

        ChangeNotifierProxyProvider<RepositorioDeLivros, LivroRequisitadoModel>(
          create: (context) => LivroRequisitadoModel(),
          update: (context, livro, informacaoDoLivro) {
            if (informacaoDoLivro == null)
              // ignore: curly_braces_in_flow_control_structures
              throw ArgumentError.notNull('Sem informacao do Livro');
            informacaoDoLivro.livro = livro;
            return informacaoDoLivro;
          },
        ),

        ChangeNotifierProvider<AuthModel>(
            create: (_) => AuthModel(firebaseAuth: FirebaseAuth.instance)),

        /// O StreamProvider() será importante para ler o valor do método
        /// estadoDeAutenticacao no AuthModel.
        StreamProvider(
          create: (context) => context.read<AuthModel>().estadoDeAutenticacao,
          initialData: null,
        ),
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
      debugShowCheckedModeBanner: false,
      home: AutenticarUtilizador(),
    );
  }
}

class AutenticarUtilizador extends StatelessWidget {
  const AutenticarUtilizador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Instância para saber o estado de autenticação.
    final firebaseUser = context.watch<User?>();

    // ignore: unnecessary_null_comparison
    if (firebaseUser != null) {
      /// O utilizador já está logado e, portanto, é redirecionado
      /// até a HomePage
      return const Home();
    }

    /// O utilizador não está conectado e, portanto, é redirecionado
    /// até LoginScreen.
    return const LoginScreen();
  }
}
