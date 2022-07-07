import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Propriedade de utilizador para retornar nulo se utilizador não estiver logado
  User? utilizador;

  /// Variavel para evitar erros de carregamento de dados do utilizador
  bool isLoading = true;

  AuthServices() {
    // Metodo para verificar toda a inicialização de login do utilizador
    _verificarAutenticacao();
  }

  _verificarAutenticacao() async {
    _firebaseAuth.authStateChanges().listen((User? user) async {
      utilizador = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUtilizador() async {
    utilizador = _firebaseAuth.currentUser;

    notifyListeners();
  }

  // MÉTODO DE REGISTO
  Future registar(String email, String senha) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: senha);

      utilizador!.reload();
      _getUtilizador();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A palavra-passe é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está registado');
      }
    }
  }

  // MÉTODO DE LOGIN
  Future login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUtilizador();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'invalid-email':
        case 'wrong-password':
        case "user-disabled":
          throw AuthException(
            'O e-mail ou a palavra-passe que inseriste não parecem pertencer a uma conta. '
            'Verifica o e-mail ou a palavra-passe e tenta novamente.',
          );

        default:
          'Não existem registos. Por favor crie uma nova conta.';
      }
    }
  }

  // MÉTODO SAIR
  Future terminarSessao() async {
    await _firebaseAuth.signOut();
    _getUtilizador();
  }

  //  MÉTODO REPOR PALAVRA-PASSE
  Future ReporPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw AuthException(
          'O teu e-mail parece estar incorreto. Tente novamente.',
        );
      }

      if (e.code == 'user-not-found') {
        throw AuthException(
          'Não existem registos do e-mail inserido. Tente novamente.',
        );
      }
    }
  }
}

// EXCEPTION
class AuthException implements Exception {
  String mensagem;
  AuthException(this.mensagem);
}
