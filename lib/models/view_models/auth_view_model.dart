import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthModel with ChangeNotifier {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// O Stream vai ser para ouvir continuamente o estado da autenticação
  /// do utilizador (se está conectado ou não) para atualizar o id token
  /// do utilizador.
  Stream<User?> get estadoDeAutenticacao => firebaseAuth.idTokenChanges();

  // Método login para o utilizador (já registado)
  static Future<User?> login({
    required String email,
    required String password,
  }) async {
    User? utilizador;

    try {
      UserCredential credenciasDoUtilizador = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      utilizador = credenciasDoUtilizador.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'utilizador-não-encontrado') {
        print('Nenhum utilizador encontrado com esse e-mail.');
      } else if (e.code == 'palavra-passe-incorreta') {
        print('Palavra-passe incorreta fornecida.');
      }
    }

    return utilizador;
  }

  /// MÉTODO SAIR
  Future terminarSessao() async {
    try {
      await firebaseAuth.signOut();
      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print(error.toString());
      return null;
    }
  }
}
