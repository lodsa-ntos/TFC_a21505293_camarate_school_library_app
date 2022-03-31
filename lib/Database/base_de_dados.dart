import 'package:firebase_database/firebase_database.dart';

class BaseDeDados {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref("livrosAleatorios");

  Future<DatabaseEvent> getLivros() async {
    final dbRef = FirebaseDatabase.instance.ref().child('livrosAleatorios');
    return await dbRef.once();
  }
}
