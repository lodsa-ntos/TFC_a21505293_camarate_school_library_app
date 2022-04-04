import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthModel with ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Construtor para iniciar a instância do FirebaseAuth
  AuthModel({required this.firebaseAuth});

  /// O Stream vai ser para ouvir continuamente o estado da autenticação
  /// do utilizador (se está conectado ou não).
  Stream<User?> get estadoDeAutenticacao => firebaseAuth.idTokenChanges();

  //MÉTODO DE LOGIN
  Future<Object> login(
      {required String email, required String password}) async {
    try {
      var resultadoAuth = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return resultadoAuth.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  /// MÉTODO SAIR
  Future<void> terminarSessao() async {
    await firebaseAuth.signOut();
    notifyListeners();
  }
}
