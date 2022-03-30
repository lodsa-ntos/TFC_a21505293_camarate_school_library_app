import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:camarate_school_library/Models/Livro/livro_model.dart';
import 'package:firebase_database/firebase_database.dart';

class BaseDeDados {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref("livrosAleatorios");
}
