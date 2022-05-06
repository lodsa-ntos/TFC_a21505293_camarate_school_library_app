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
    /// Metodo para verificar toda a inicialização de login do utilizador
    _verificarAutenticacao();
  }

  _verificarAutenticacao() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      utilizador = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUtilizador() {
    utilizador = _firebaseAuth.currentUser;
    notifyListeners();
  }

  // MÉTODO DE REGISTO
  Future registar(String email, String senha) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: senha);
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
      if (e.code == 'user-not-found') {
        throw AuthException(
            'Desculpa, mas o teu e-mail e a tua palavra-passe não pertence a nenhuma conta. Verifica, e tenta novamente.');
      } else if (e.code == 'invalid-email') {
        throw AuthException(
            'O teu e-mail parece estar incorreto. Verifica-a novamente.');
      } else if (e.code == 'wrong-password') {
        throw AuthException(
            'A tua palavra-passe estava incorreta. Verifica-a novamente.');
      }
    }
  }

  /// MÉTODO SAIR
  Future terminarSessao() async {
    await _firebaseAuth.signOut();
    _getUtilizador();
  }
}

// EXCEPTION
class AuthException implements Exception {
  String mensagem;
  AuthException(this.mensagem);
}
