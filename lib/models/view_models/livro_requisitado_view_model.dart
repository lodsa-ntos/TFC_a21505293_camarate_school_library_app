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

  Map<String, Livro> _livrosRequisitado = {};

  Map<String, Livro> get livros {
    return {..._livrosRequisitado};
  }

  int get livroCount {
    return _livrosRequisitado.length;
  }

  Future<void> addLivroRequisitado(Livro livro) async {
    // Se a chave já existir, o valor atual é retornado.
    _livrosRequisitado.putIfAbsent(
      livro.id.toString(),
      () => Livro(
        id: livro.id,
        titulo: livro.titulo,
        autor: livro.autor,
        isbn: livro.isbn,
        editora: livro.editora,
        imagePath: livro.imagePath,
        ano: livro.ano,
        numRegisto: livro.numRegisto,
        isRequisitado: livro.isRequisitado,
        uidLivro: livro.uidLivro,
      ),
    );
    notifyListeners();
  }

  void devolverLivroRequisitado(Livro livro) {
    _livrosRequisitado.remove(livro.id);
    notifyListeners();
  }

  Map<String, Livro> get livro => _livrosRequisitado;

  set livro(Map<String, Livro> novoLivro) {
    _livrosRequisitado = novoLivro;
    notifyListeners();
  }
}
