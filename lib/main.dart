import 'package:camarate_school_library/Screens/Home/home.dart';
import 'package:camarate_school_library/Screens/login.dart';
import 'package:camarate_school_library/Models/Auth/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/Livro/livro_requisitado_model.dart';

final referenciaBD = FirebaseDatabase.instance.ref().child('livros');

Future<void> main() async {
  /// Necessário para usar canais para chamar o código nativo
  /// para inicializar o Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LivroRequisitadoModel()),

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
