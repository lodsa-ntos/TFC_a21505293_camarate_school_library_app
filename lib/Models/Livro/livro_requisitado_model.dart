import 'package:camarate_school_library/Models/Livro/livro.dart';
import 'package:flutter/material.dart';

import 'repositorio_de_livros.dart';

class LivroRequisitadoModel extends ChangeNotifier {
  // Variável privada [_livrosComIds], para chamar e guardar o livro por id. */
  late RepositorioDeLivros _livrosComIds;

  // Lista privada para armazenar os ids de cada livro */.
  final List<int> _idsDoslivros = [];

  // Com esta variável [_livro] obtenho os livros por ids */
  RepositorioDeLivros get livro => _livrosComIds;

  // Lista para guardar os livros por id na lista de _idsDoslivros no formato de uma lista. */
  List<Livro> get livros =>
      _idsDoslivros.map((id) => _livrosComIds.getPorId(id)).toList();

  // Adicionar o [livro requisitado] na lista pelo os ids. */
  void addLivroRequisitado(Livro livro) {
    _idsDoslivros.add(livro.id);

    /// Notifica, caso exista um livro que foi requisitado
    notifyListeners();
  }

  void devolverLivroRequisitado(Livro livro) {
    _idsDoslivros.remove(livro.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }

  //** Importante para o usar o ChangeNotifierProxyProvider
  //** para atualizar a informacao de um novo livro */
  set livro(RepositorioDeLivros novoLivro) {
    _livrosComIds = novoLivro;

    /// Notifica, caso exista um novo livro
    notifyListeners();
  }
}
