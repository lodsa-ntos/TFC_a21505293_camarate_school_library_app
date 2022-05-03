import 'package:camarate_school_library/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivroRequisitadoModel extends ChangeNotifier {
  /// Map para guardar o formato de como os livros serao addLivroRequisitado
  /*id: livro.id,
        titulo: livro.titulo,
        autor: livro.autor,
        isbn: livro.isbn,
        editora: livro.editora,
        imagePath: livro.imagePath,
        ano: livro.ano,
        isRequisitado: livro.isRequisitado,*/

  Map<String, LivroModel> _livrosRequisitado = {};

  Map<String, LivroModel> get livros {
    return {..._livrosRequisitado};
  }

  int get livroCount {
    return _livrosRequisitado.length;
  }

  Future<void> addLivroRequisitado(LivroModel livro) async {
    // Se a chave já existir, o valor atual é retornado.
    _livrosRequisitado.putIfAbsent(
      livro.id.toString(),
      () => LivroModel(
        id: livro.id,
        titulo: livro.titulo,
        autor: livro.autor,
        isbn: livro.isbn,
        editora: livro.editora,
        imagePath: livro.imagePath,
        ano: livro.ano,
        numRegisto: livro.numRegisto,
        isRequisitado: livro.isRequisitado,
        uid: livro.uid,
      ),
    );
    notifyListeners();
  }

  void devolverLivroRequisitado(LivroModel livro) {
    _livrosRequisitado.remove(livro.id);
    notifyListeners();
  }

  Map<String, LivroModel> get livro => _livrosRequisitado;

  set livro(Map<String, LivroModel> novoLivro) {
    _livrosRequisitado = novoLivro;
    notifyListeners();
  }
}
