import 'package:firebase_database/firebase_database.dart';

class BaseDeDados {
  DatabaseReference reference = FirebaseDatabase.instance.ref();
  /*getLivros() async {
    final snapshot =
        await FirebaseDatabase.instance.ref('livrosAleatorios').get();

    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final livro = LivroModel.fromMap(value);

      list.add(livro);
    });
  }*/
}
