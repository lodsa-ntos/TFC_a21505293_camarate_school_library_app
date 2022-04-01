import 'package:firebase_database/firebase_database.dart';

class BaseDeDados {
  DatabaseReference ref = FirebaseDatabase.instance.ref("livrosAleatorios");
}
