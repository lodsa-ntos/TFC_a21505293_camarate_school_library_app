import 'dart:io';

import 'package:camarate_school_library/screens/menu_lateral/menu_lateral.dart';
import 'package:camarate_school_library/screens/splash_screen.dart';
import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  /// Necessário para usar canais para chamar o código nativo
  /// para inicializar o Firebase.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa uma nova instância [FirebaseApp] por [nome] e [opções] e retorna o aplicação criada.
  await Firebase.initializeApp();

  runApp(
    // Construir a árvore de providers para gerar a mudança em todos os widgets que formam a aplicação
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LivroRequisitadoModel()),
        ChangeNotifierProvider(create: (_) => AuthServices()),
      ],

      //** APLICAÇÃO
      child: const CamarateSchoolLibraryApp(),
    ),
  );

  // O HttpOverrides facilita a substituição de [HttpClient] com uma implementação simulada.
  // Permite carregar imgens network
  HttpOverrides.global = MyHttpOverrides();
}

class CamarateSchoolLibraryApp extends StatelessWidget {
  const CamarateSchoolLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tirar a marca do debug na applicação
      debugShowCheckedModeBanner: false,
      // Restrição de entrada na aplicação, para identificar o utilizador
      home: AutenticarUtilizador(),
    );
  }
}

class AutenticarUtilizador extends StatelessWidget {
  const AutenticarUtilizador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Instância para saber o estado de autenticação.
    AuthServices autenticacao = Provider.of<AuthServices>(context);

    if (autenticacao.isLoading) {
      return aCarregarPagina();
    } else if (autenticacao.utilizador == null) {
      return const IniciarApp();
    } else {
      return const MenuLateral();
    }
  }

  aCarregarPagina() {
    return Scaffold(
      body: Center(
        child: Platform.isAndroid
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

// O HttpOverrides facilita a substituição de [HttpClient] com uma implementação simulada.
// Permite carregar imgens network
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
