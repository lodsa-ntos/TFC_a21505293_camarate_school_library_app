import 'package:firebase_auth/firebase_auth.dart';

class Utilizador {
  String? uid;
  String? email;
  String? password;

  // Construtor
  Utilizador({
    this.uid,
    this.email,
    this.password,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Utilizador &&
        other.uid == uid &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ password.hashCode;
}
