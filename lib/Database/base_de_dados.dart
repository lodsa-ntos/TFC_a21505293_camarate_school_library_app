import 'dart:async';

import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:firebase_database/firebase_database.dart';

class BaseDeDados {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Future<StreamSubscription<DatabaseEvent>> getTodosLivros(
      String id, void Function(LivroModel todosLivros) onData) async {
    StreamSubscription<DatabaseEvent> referenciaBaseDeDados = FirebaseDatabase
        .instance
        .ref()
        .child("livrosAleatorios")
        .child(id)
        .onValue
        .listen((event) {
      var livro = LivroModel.fromJson(
          event.snapshot.key, event.snapshot.value as Map<dynamic, dynamic>);
      onData(livro);
    });

    return referenciaBaseDeDados;
  }
}
