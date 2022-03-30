import 'package:camarate_school_library/Models/Livro/livro_model.dart';
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

  /*Future<List<LivroModel>> livros() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('dogs');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return LivroModel(
      id: maps[i]['id'],
      titulo: maps[i]['titulo'],
      autor: maps[i]['autor'],
      isbn: maps[i]['isbn'],
      editora: maps[i]['editora'],
      imagePath: maps[i]['imagePath'],
      data: maps[i]['data'],
      ano: maps[i]['ano'],
      isRequisitado: maps[i]['isRequisitado'],
      isDisponivel: maps[i]['isDisponivel'],
    );
  });
}*/
}
