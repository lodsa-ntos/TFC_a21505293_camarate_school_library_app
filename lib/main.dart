import 'dart:io';

import 'package:camarate_school_library/screens/menu_lateral.dart';
import 'package:camarate_school_library/services/auth_services.dart';
import 'package:camarate_school_library/models/view_models/livro_requisitado_view_model.dart';
import 'package:camarate_school_library/screens/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  /// Necessário para usar canais para chamar o código nativo
  /// para inicializar o Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LivroRequisitadoModel()),
        ChangeNotifierProvider(create: (_) => AuthServices()),
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
    AuthServices autenticacao = Provider.of<AuthServices>(context);

    if (autenticacao.isLoading) {
      return aCarregarPagina();
    } else if (autenticacao.utilizador == null) {
      return const LoginScreen();
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
