import 'package:firebase_database/firebase_database.dart';

class BaseDeDados {
  DatabaseReference referenceBase =
      FirebaseDatabase.instance.reference().child('livrosAleatorios');
}
