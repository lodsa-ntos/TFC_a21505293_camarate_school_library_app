import 'package:camarate_school_library/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivroRequisitadoModel extends ChangeNotifier {
  RepositorioDeLivros? _livrosComIds;

  final List<String> _idsDoslivros = [];

  List<LivroModel> get livros =>
      _idsDoslivros.map((id) => _livrosComIds!.getPorId(id)).toList();

  // Adicionar o [livro requisitado] na lista pelo os ids. */
  void addLivroRequisitado(LivroModel livro) {
    _idsDoslivros.add(livro.id.toString());
    notifyListeners();
  }

  void devolverLivroRequisitado(LivroModel livro) {
    _idsDoslivros.remove(livro.id);
    notifyListeners();
  }

  set livro(RepositorioDeLivros novoLivro) {
    _livrosComIds = novoLivro;
    notifyListeners();
  }
}
